import 'dart:math';

import 'package:raylib/raylib.dart';

final _random = Random();
// double getRandomValue(double min, double max) {
//   return min + _random.nextDouble() * max;
// }

int getRandomInt(int min, int max) {
  return min + _random.nextInt(max - min);
}
