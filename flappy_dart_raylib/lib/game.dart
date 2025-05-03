import 'package:raylib/raylib.dart';
import 'package:flappy_dart/bird.dart';
import 'package:flappy_dart/pipe.dart';
import 'package:flappy_dart/flappy_dart.dart' as fd;

class Game {
  final int gravity = 10;
  final double pipeSpeed = 200.0;
  final int pipeGap = 130;
  final Texture2D pipeTex = loadTexture("assets/pipe.png");
  
  int pipeWidth = 0;
  bool gameOver = false;
  int score = 0;
  double pipeSpawnTimer = 0.0;
  double pipeSpawnInterval = 2.0;

  int windowWidth = 0;
  int windowHeight = 0;

  bool debug = false;

  Bird bird = Bird(Vector2(0.0, 0.0));

  var pipes = [];

  Game(this.windowWidth, this.windowHeight) {
    this.bird = Bird(Vector2(this.windowWidth / 4.0, this.windowHeight / 4.0));
    this.pipeWidth = this.pipeTex.width;
  }


  void run() {
    double deltaTime = getFrameTime();

    if (!this.gameOver) {
      bird.vel.y += this.gravity;
      
      bird.update(deltaTime);
      bird.input();

      if(isKeyPressed(KeyboardKey.d)) {
        this.debug = !this.debug;
      }
      
      // Spawn Pipes
      this.pipeSpawnTimer += deltaTime;

      if (this.pipeSpawnTimer >= this.pipeSpawnInterval) {
        this.pipeSpawnTimer = 0.0;
        num gapPosition = fd.getRandomInt(100, this.windowHeight - 100 - this.pipeGap); 
        this.pipes.add(Pipe(Vector2(windowWidth.toDouble(), gapPosition.toDouble()), this.pipeTex));
      }
      
      for (var pipe in pipes) {
        pipe.pos.x -= this.pipeSpeed * deltaTime;

        // Score counting
        if (!pipe.passed && pipe.pos.x + pipeWidth < bird.pos.x) {
            this.score++;
            pipe.passed = true;
        }
      }

      // Remove off-screen pipes
      if (pipes.length != 0 && pipes[0].pos.x + pipeWidth < 0) {
          pipes.remove(0);
      }

      // Collision detection
      // Ground collision
      if (bird.pos.y + bird.radius > this.windowHeight) {
          this.gameOver = true;
      }
      // Ceiling collision
      if (bird.pos.y - bird.radius < 0.0) {
          bird.pos.y = bird.radius;
          bird.vel.y = 0.0;
      }

      for (var pipe in pipes) {
        // Top pipe (original orientation)
        Rectangle topPipeRect = Rectangle(
            pipe.pos.x,
            (pipe.pos.y - this.pipeTex.height).toDouble(),
            pipeTex.width.toDouble(),
            pipeTex.height.toDouble(),
        );

        // Bottom pipe (flipped vertically)
        Rectangle bottomPipeRect = Rectangle(
            pipe.pos.x,
            (pipe.pos.y + pipeGap).toDouble(),
            this.pipeTex.width.toDouble(),
            this.pipeTex.height.toDouble(),
        );

        if (checkCollisionCircleRec(bird.pos, bird.radius, topPipeRect) ||
          checkCollisionCircleRec(bird.pos, bird.radius, bottomPipeRect)) {
          this.gameOver = true;
        }

      }

    } else {
      // Restart game
      if (isKeyPressed(KeyboardKey.r)) {
          bird.pos = Vector2(windowWidth / 4.0, windowHeight / 2.0);
          bird.vel = Vector2(0.0, 0.0);
          this.pipes.clear();
          this.score = 0;
          this.gameOver = false;
      }
    }
  }

  void render() {
    if (!this.gameOver) {
      // Draw pipes
      for (final pipe in pipes) {
        pipe.render(this.pipeGap);
        if (this.debug) {
          Rectangle topPipeRect = Rectangle(
            pipe.pos.x,
            (pipe.pos.y - this.pipeTex.height).toDouble(),
            pipeTex.width.toDouble(),
            pipeTex.height.toDouble(),
          );

          // Bottom pipe (flipped vertically)
          Rectangle bottomPipeRect = Rectangle(
              pipe.pos.x,
              (pipe.pos.y + pipeGap).toDouble(),
              this.pipeTex.width.toDouble(),
              this.pipeTex.height.toDouble(),
          );
          drawRectangleLinesEx(topPipeRect, 1.5, Color.red);
          drawRectangleLinesEx(bottomPipeRect, 1.5, Color.red);
        }
      }

      // Draw bird
      if (this.debug) {
        drawCircleLines(bird.pos.x.toInt(), bird.pos.y.toInt(), bird.radius, Color.red);
      }
      bird.render();
    } else {
      drawText("Game Over!", (this.windowWidth/2).toInt() - 100, (this.windowHeight/2).toInt() - 20, 40, Color.red);
      drawText("Press R to restart", (this.windowWidth/2).toInt() - 95, (this.windowHeight/2).toInt() + 30, 20, Color.darkGray);
    }

    // Draw score
    drawText("Score: ${score}", 15, 15, 26, Color.white);
    drawFPS(15, 45);
  }

  void unload() {
    bird.unload_textures();
    unloadTexture(this.pipeTex);
  }

}
