import 'package:flutter/material.dart';
import 'package:flutter_flappy_bird/game/flappy_game.dart';

import '../game/assets.dart';

class MainMenuScreen extends StatelessWidget {

  final FlappyBirdGame game;
  static const String id = 'mainMenu';

  const MainMenuScreen({super.key, required this.game});


  @override
  Widget build(BuildContext context) {
    game.pauseEngine();

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          game.overlays.remove('mainMenu');
          game.resumeEngine();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage(Assets.menu),
            fit: BoxFit.cover,
            ),
          ),
          child: Image.asset(Assets.message),
        ),
      ),
    );
  }
}
