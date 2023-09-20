import 'dart:convert';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather/weather.dart';

import '../../_fixtures/json_fixture_reader.dart';
import '../../_utils/mocks.dart';

void main() {
  final jsonString = fixture('sao_paulo_current_weather_fixture.json');
  final json = jsonDecode(jsonString) as Map<String, dynamic>;

  const params = WeatherFetchingInput(latitude: 0.0, longitude: 0.0, locale: 'en_US', cityName: '');
  final key = params.cacheKey;

  group('LocallyFetchCurrentWeather', () {
    late LocallyFetchCurrentWeather locallyFetchCurrentWeather;
    late MockRead mockStorage;

    setUp(() {
      mockStorage = MockRead();
      locallyFetchCurrentWeather = LocallyFetchCurrentWeather(mockStorage);
    });

    test('should return a WeatherForecast from cached data', () async {
      // Arrange
      when(() => mockStorage.read(key: key)).thenAnswer((_) async => jsonEncode(json));

      // Act
      final result = await locallyFetchCurrentWeather(params);

      // Assert
      verify(() => mockStorage.read(key: key));
      expect(result, isA<WeatherForecast>());
    });

    test('should throw a ReadingFailure if cached data is not found', () async {
      // Arrange
      when(() => mockStorage.read(key: key)).thenThrow(ReadingFailure(key: key));

      // Act and assert
      expect(() => locallyFetchCurrentWeather(params), throwsA(isA<ReadingFailure>()));
      verify(() => mockStorage.read(key: key));
    });
  });
}
