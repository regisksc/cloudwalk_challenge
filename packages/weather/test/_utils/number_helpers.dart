import 'dart:math';

double randomNumber({double min = -200, double max = 200}) {
  assert(min < max);
  final random = Random();
  return min + random.nextDouble() * (max - min);
}
