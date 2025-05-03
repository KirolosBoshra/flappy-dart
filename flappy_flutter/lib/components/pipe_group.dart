import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';

// ignore: unused_import
import 'package:flutter/cupertino.dart';
import 'package:flutter_flappy_bird/components/pipe.dart';
import 'package:flutter_flappy_bird/game/configuration.dart';
import 'package:flutter_flappy_bird/game/flappy_game.dart';
import 'package:flutter_flappy_bird/game/pipe_position.dart';

import '../game/assets.dart';

class PipeGroup extends PositionComponent with HasGameRef<FlappyBirdGame> {
  PipeGroup();

  final random = Random();

  @override
  Future<void> onLoad() async {
    position.x = gameRef.size.x;

    final heightMinusGround = gameRef.size.y - Config.groundHeight;
    final spacing = 140 + random.nextDouble() * (heightMinusGround / 4);
    final centerY =
        spacing + random.nextDouble() * (heightMinusGround - spacing);
    addAll([
      Pipe(pipePosition: PipePosition.top, height: centerY - spacing / 2),
      Pipe(
        pipePosition: PipePosition.bottom,
        height: heightMinusGround - (centerY + spacing / 2),
      ),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= Config.gameSpeed * dt;

    if (position.x < -10) {
      removeFromParent();
      //debugPrint('Removed');
      updateScore();
    }
    if (gameRef.isHit) {
      removeFromParent();
      gameRef.isHit = false;
    }
  }

  void updateScore() {
    gameRef.bird.score += 1;
    FlameAudio.play(Assets.point);
  }
}
