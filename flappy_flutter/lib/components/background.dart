import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter_flappy_bird/game/flappy_game.dart';
import '../game/assets.dart';

class Background extends SpriteComponent with HasGameRef<FlappyBirdGame>{
  Background();

  @override
  Future<void> onLoad() async {
    final background = await Flame.images.load(Assets.background);
    size = gameRef.size;
    sprite = Sprite(background);

  }
}