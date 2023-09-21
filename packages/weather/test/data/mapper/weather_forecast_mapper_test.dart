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
      final jsonString = fixture('sao_paulo_current_weather_fixture.json');
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      sut = WeatherForecastMapper.fromJson(json);

      expectedTime = DateTime.fromMillisecondsSinceEpoch((json['dt'] as int) * 1000).formatted();
      expectedWeatherDescription =
          ((json['weather'] as List<dynamic>).firstOrNull as Map<String, dynamic>)['description'] ?? 'N/A';
      expectedWindSpeed = WindSpeed(value: json['wind']['speed'] as num);
      expectedTempMin = Temperature(value: json['main']['temp_min'] as num);
      expectedTempMax = Temperature(value: json['main']['temp_max'] as num);
    });
    group("its time ...", () {
      test('is a String', () => expect(sut.time, isA<ForecastTime>()));
      test('is as expected', () => expect(sut.time.formatted, equals(expectedTime)));
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

  test('toJson should return a valid JSON map', () {
    final weatherForecastMapper = WeatherForecastMapper(
      time: ForecastTime(unixTimestamp: 1631881200),
      tempMin: Temperature(value: 10.0),
      tempMax: Temperature(value: 20.0),
      weatherDescription: 'Sunny',
      windSpeed: WindSpeed(value: 5.0),
      modifiedWhen: DateTime.now().toUtc(),
    );

    final json = weatherForecastMapper.toJson();

    expect(json, isA<Map<String, dynamic>>());
    expect(json['dt'], isA<int>());
    expect(json['main'], isA<Map<String, dynamic>>());
    expect(json['main']['temp_min'], 10.0);
    expect(json['main']['temp_max'], 20.0);
    expect(json['weather'], isA<List<dynamic>>());
    expect(json['weather'][0], isA<Map<String, dynamic>>());
    expect(json['weather'][0]['description'], 'Sunny');
    expect(json['wind'], isA<Map<String, dynamic>>());
    expect(json['wind']['speed'], 5.0);
  });

  test('copyWith should create a new instance with modifiedWhen updated', () {
    final originalModifiedWhen = DateTime(2023, 9, 17, 12);
    final weatherForecastMapper = WeatherForecastMapper(
      time: ForecastTime(unixTimestamp: 1631881200),
      tempMin: Temperature(value: 10.0),
      tempMax: Temperature(value: 20.0),
      weatherDescription: 'Sunny',
      windSpeed: WindSpeed(value: 5.0),
      modifiedWhen: originalModifiedWhen,
    );

    final newModifiedWhen = DateTime(2023, 9, 18, 12);
    final updatedWeatherForecastMapper = weatherForecastMapper.copyWith(modifiedWhen: newModifiedWhen);

    expect(updatedWeatherForecastMapper, isA<WeatherForecastMapper>());
    expect(updatedWeatherForecastMapper.modifiedWhen, newModifiedWhen);
  });

  test('asEntity should return a WeatherForecast entity', () {
    final weatherForecastMapper = WeatherForecastMapper(
      time: ForecastTime(unixTimestamp: 1631881200),
      tempMin: Temperature(value: 10.0),
      tempMax: Temperature(value: 20.0),
      weatherDescription: 'Sunny',
      windSpeed: WindSpeed(value: 5.0),
      modifiedWhen: DateTime.now().toUtc(),
    );

    final weatherForecast = weatherForecastMapper.asEntity;

    expect(weatherForecast, isA<WeatherForecast>());
    expect(weatherForecast.time, isA<ForecastTime>());
    expect(weatherForecast.tempMin, isA<Temperature>());
    expect(weatherForecast.tempMax, isA<Temperature>());
    expect(weatherForecast.weatherDescription, 'Sunny');
    expect(weatherForecast.windSpeed, isA<WindSpeed>());
  });

  test('asEntities should return a list of WeatherForecast entities', () {
    final weatherForecastMapperList = [
      WeatherForecastMapper(
        time: ForecastTime(unixTimestamp: 1631881200),
        tempMin: Temperature(value: 10.0),
        tempMax: Temperature(value: 20.0),
        weatherDescription: 'Sunny',
        windSpeed: WindSpeed(value: 5.0),
        modifiedWhen: DateTime.now().toUtc(),
      ),
      WeatherForecastMapper(
        time: ForecastTime(unixTimestamp: 1631882200),
        tempMin: Temperature(value: 15.0),
        tempMax: Temperature(value: 25.0),
        weatherDescription: 'Cloudy',
        windSpeed: WindSpeed(value: 6.0),
        modifiedWhen: DateTime.now().toUtc(),
      ),
    ];

    final weatherForecasts = weatherForecastMapperList.asEntities;

    expect(weatherForecasts, isA<List<WeatherForecast>>());
    expect(weatherForecasts.length, 2);

    for (final weatherForecast in weatherForecasts) {
      expect(weatherForecast, isA<WeatherForecast>());
      expect(weatherForecast.time, isA<ForecastTime>());
      expect(weatherForecast.tempMin, isA<Temperature>());
      expect(weatherForecast.tempMax, isA<Temperature>());
      expect(weatherForecast.windSpeed, isA<WindSpeed>());
    }
  });
}
