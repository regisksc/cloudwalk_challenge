import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weather/weather.dart';

import '../../_fixtures/json_fixture_reader.dart';

void main() {
  group('fromJson should create a WeatherForecastMapper and...', () {
    late WeatherForecastMapper sut;

    late final String expectedTime;
    late final String expectedWeatherDescription;
    late final WindSpeed expectedWindSpeed;
    late final Temperature expectedTempMin;
    late final Temperature expectedTempMax;

    setUpAll(() async {
      await initializeDateFormatting('en_US');
      final jsonString = fixture('sao_paulo_weather_fixture.json');
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      final listData = json['list'] as List<dynamic>;
      final itemJson = listData.firstOrNull;
      sut = WeatherForecastMapper.fromJson(itemJson);

      expectedTime = DateTime.fromMillisecondsSinceEpoch((itemJson['dt'] as int) * 1000).formatted();
      expectedWeatherDescription =
          ((itemJson['weather'] as List<dynamic>).firstOrNull as Map<String, dynamic>)['description'] ?? 'N/A';
      expectedWindSpeed = WindSpeed(value: itemJson['wind']['speed'] as num);
      expectedTempMin = Temperature(value: itemJson['main']['temp_min'] as num);
      expectedTempMax = Temperature(value: itemJson['main']['temp_max'] as num);
    });
    group("its time ...", () {
      test('is a String', () => expect(sut.time, isA<String>()));
      test('is as expected', () => expect(sut.time, equals(expectedTime)));
    });

    group("its tempMin ...", () {
      test('is a Temperature', () => expect(sut.tempMin, isA<Temperature>()));
      test('is as expected', () => expect(sut.tempMin, equals(expectedTempMin)));
    });

    group("its tempMax ...", () {
      test('is a Temperature', () => expect(sut.tempMax, isA<Temperature>()));
      test('is as expected', () => expect(sut.tempMax, equals(expectedTempMax)));
    });

    group("its weatherDescription ...", () {
      test('is a String', () => expect(sut.weatherDescription, isA<String>()));
      test('is as expected', () => expect(sut.weatherDescription, equals(expectedWeatherDescription)));
    });

    group("its windSpeed ...", () {
      test('is a WindSpeed object', () => expect(sut.windSpeed, isA<WindSpeed>()));
      test('is as expected', () => expect(sut.windSpeed, equals(expectedWindSpeed)));
    });
  });
}
