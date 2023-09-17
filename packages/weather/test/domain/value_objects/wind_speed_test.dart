import 'package:flutter_test/flutter_test.dart';
import 'package:weather/domain/domain.dart';

import '../../_utils/number_helpers.dart';

void main() {
  group('WindSpeed class tests', () {
    test('Wind speed below 10 mph should have "low" danger', () {
      final windSpeed = WindSpeed(value: randomNumber(max: 9));
      expect(windSpeed.danger, equals(WindSpeedDanger.low));
    });

    test('Wind speed between 10 and 20 mph should have "moderate" danger', () {
      final windSpeed = WindSpeed(value: randomNumber(min: 10, max: 20));
      expect(windSpeed.danger, equals(WindSpeedDanger.moderate));
    });

    test('Wind speed above or equal to 20 mph should have "high" danger', () {
      final windSpeed = WindSpeed(value: randomNumber(min: 20));
      expect(windSpeed.danger, equals(WindSpeedDanger.high));
    });
  });
}
