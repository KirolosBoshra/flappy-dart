import 'package:raylib/raylib.dart';

class Bird { 
  Vector2 pos;
  Vector2 vel = Vector2(0.0, 0.0);
  Vector2 origin = Vector2(0.0, 0.0);
  double angle = 0.0;
  double radius = 17.0;
  var textures = [];
  
  final double jump_force = -300;
  
  int currentFrame = 0;
  int framesCounter = 0;
  int framesSpeed = 6;
  
  Bird(this.pos) {
    this.textures = [
      loadTexture('assets/yellowbird_midflap.png'),
      loadTexture('assets/yellowbird_upflap.png'),
      loadTexture('assets/yellowbird_downflap.png')
    ];
    this.origin.x = this.textures[0].width/2.0;
    this.origin.y = this.textures[0].height/2.0;
  }

  void update(double dt) {
    // Animation
    framesCounter++;

    if (framesCounter >= (getFPS()/this.framesSpeed)){
        framesCounter = 0;
        currentFrame++;

        if (currentFrame > this.textures.length-1) {
          currentFrame = 0;
        }
    }
    
    // Physics
    this.pos.y += this.vel.y * dt;
    this.angle = this.vel.y * 0.15;
    this.angle.clamp(-30.0, 30.0);
  }

  void input() {
    if (isKeyPressed(KeyboardKey.space) 
        || isKeyPressed(KeyboardKey.up) || isMouseButtonPressed(MouseButton.left)) {
      this.vel.y = this.jump_force;
      this.angle = -25.0;
    }
  }

  void render() {
    // drawTextureEx(this.textures[currentFrame], this.pos, this.angle, 1.0, Color.white);
    drawTexturePro(
      this.textures[currentFrame],
      Rectangle(
        0.0, 0.0, 
        this.textures[currentFrame].width.toDouble(), 
        this.textures[currentFrame].height.toDouble()
      ),
      Rectangle(
        this.pos.x, 
        this.pos.y, 
        this.textures[currentFrame].width.toDouble(),
        this.textures[currentFrame].height.toDouble(),
      ),
      this.origin,
      this.angle,
      Color.white
    );
  }

  void unload_textures() {
    for (var tex in this.textures) {
      unloadTexture(tex);
    }
  }

}
