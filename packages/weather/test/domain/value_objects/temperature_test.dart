import 'package:flutter_test/flutter_test.dart';
import 'package:weather/domain/domain.dart';

import '../../_utils/number_helpers.dart';

void main() {
  group('Temperature class tests', () {
    test('Temperature below 32°F should have "unbearablyCold" danger', () {
      final temperature = Temperature(value: randomNumber(max: 32));
      expect(temperature.danger, equals(TemperatureDanger.unbearablyCold));
    });

    test('Temperature between 32°F and 59°F should have "cold" danger', () {
      final temperature = Temperature(value: randomNumber(min: 32, max: 59));
      expect(temperature.danger, equals(TemperatureDanger.cold));
    });

    test('Temperature between 59°F and 77°F should have "warm" danger', () {
      final temperature = Temperature(value: randomNumber(min: 59, max: 77));
      expect(temperature.danger, equals(TemperatureDanger.warm));
    });

    test('Temperature between 77°F and 95°F should have "hot" danger', () {
      final temperature = Temperature(value: randomNumber(min: 77, max: 95));
      expect(temperature.danger, equals(TemperatureDanger.hot));
    });

    test('Temperature above 95°F should have "unbearablyHot" danger', () {
      final temperature = Temperature(value: randomNumber(min: 95));
      expect(temperature.danger, equals(TemperatureDanger.unbearablyHot));
    });
  });
}
