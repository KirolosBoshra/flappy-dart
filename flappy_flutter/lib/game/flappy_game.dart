import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter_flappy_bird/components/background.dart';
import 'package:flutter_flappy_bird/components/bird.dart';
import 'package:flutter_flappy_bird/components/ground.dart';
import 'package:flutter_flappy_bird/components/pipe_group.dart';
import 'package:flutter_flappy_bird/game/configuration.dart';
import 'package:flutter/material.dart' show TextStyle, FontWeight;

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  late Bird bird;
  late TextComponent score;
  Timer interval = Timer(Config.pipeInterval, repeat: true);
  bool isHit = false;

  @override
  Future<void> onLoad() async {
    addAll([
      Background(),
      Ground(),
      bird = Bird(),
      PipeGroup(),
      score = buildScore(),
    ]);

    interval.onTick = () => add(PipeGroup());
  }

  TextComponent buildScore() {
    final textPaint = TextPaint(
      style: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        fontFamily: 'Game',
        color: const Color(0xFFFFFFFF),
      ),
    );

    return TextComponent(
      text: 'Score: 0',
      position: Vector2(size.x / 2, size.y / 2 * 0.2),
      anchor: Anchor.center,
      textRenderer: textPaint,
    );
  }

  @override
  void onTap() {
    super.onTap();
    bird.fly();
  }

  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt);

    score.text = 'Score: ${bird.score}';
  }
}
