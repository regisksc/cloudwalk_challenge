import 'dart:convert';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather/weather.dart';

import '../../_fixtures/json_fixture_reader.dart';
import '../../_utils/mocks.dart';

void main() {
  final jsonString = fixture('sao_paulo_weather_fixture.json');
  final Map<String, dynamic> json = jsonDecode(jsonString);
  json['list'] = jsonEncode(json['list']);

  const params = WeatherFetchingInput(latitude: 0.0, longitude: 0.0, locale: 'en_US', cityName: '');
  final key = 'list_${params.cacheKey}';

  group('LocallyFetchWeatherForecast', () {
    late LocallyFetchWeatherForecast locallyFetchWeatherForecast;
    late MockRead mockStorage;

    setUp(() {
      mockStorage = MockRead();
      locallyFetchWeatherForecast = LocallyFetchWeatherForecast(mockStorage);
    });

    test('should return a list of WeatherForecast from cached data', () async {
      // Arrange
      when(() => mockStorage.read(key: key)).thenAnswer((_) => Future.value(jsonEncode(json)));

      // Act
      final result = await locallyFetchWeatherForecast(params);

      // Assert
      verify(() => mockStorage.read(key: key));
      expect(result, isA<List<WeatherForecast>>());
    });

    test('should throw a ReadingFailure if cached data is not found', () async {
      // Arrange
      when(() => mockStorage.read(key: key)).thenThrow(ReadingFailure(key: key));

      // Act and assert
      expect(() => locallyFetchWeatherForecast(params), throwsA(isA<ReadingFailure>()));
      verify(() => mockStorage.read(key: key));
    });
  });
}
