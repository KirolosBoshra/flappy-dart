import 'package:flappy_dart/bird.dart';
import 'package:flappy_dart/game.dart';
import 'package:raylib/raylib.dart';

void main(List<String> arguments) {

  initLibrary(
    windows: 'raylib_lib/raylib.dll',
  );

  const screenWidth = 360;
  const screenHeight = 600;

  initWindow(
    screenWidth,
    screenHeight,
    'Flappy Dart',
  );

  setTargetFPS(60);

  Game game = Game(screenWidth, screenHeight);


  while (!windowShouldClose()) {
    game.run();
    beginDrawing();
    clearBackground(Color.skyBlue);
    game.render();
    endDrawing();
  }

  closeWindow();

  game.unload();

}
