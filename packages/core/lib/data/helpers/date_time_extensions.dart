import 'dart:math';

double randomNumber({double min = -200, double max = double.maxFinite}) {
  assert(min < max);
  final random = Random();
  return min + random.nextDouble() * (max - min);
}
