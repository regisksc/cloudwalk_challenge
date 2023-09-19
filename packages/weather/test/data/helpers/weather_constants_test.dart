import 'package:flutter_test/flutter_test.dart';
import 'package:weather/data/data.dart';

void main() {
  test('forecastPath should return the correct path', () {
    const expectedPath = '/data/2.5/forecast';
    final actualPath = WeatherConstants.forecastPath;
    expect(actualPath, expectedPath);
  });
}
