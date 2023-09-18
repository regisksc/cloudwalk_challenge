import 'package:flutter_test/flutter_test.dart';
import 'package:weather/weather.dart';

void main() {
  group('ForecastTime', () {
    test('formatted property should be correct for a given timestamp', () {
      const unixTimestamp = 1631875200;

      final forecastTime = ForecastTime(unixTimestamp: unixTimestamp);

      expect(forecastTime.formatted, 'Fri, Sep 17, 21');
    });
  });
}
