import 'dart:convert';

import 'package:core/core.dart';
import 'package:core/exports/exports.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather/weather.dart';

import '../../_fixtures/json_fixture_reader.dart';

class MockClient extends Mock implements HttpClient {}

void main() {
  late HttpClient client;
  late RemotelyFetchWeatherForecast sut;

  late WeatherForcastInput inputParams;

  final jsonString = fixture('sao_paulo_weather_fixture.json');
  final json = jsonDecode(jsonString) as Map<String, dynamic>;

  setUp(() {
    inputParams = WeatherForcastInput(
      latitude: faker.geo.latitude(),
      longitude: faker.geo.longitude(),
    );
    client = MockClient();
    sut = RemotelyFetchWeatherForecast(client);
  });

  setUpAll(() {
    registerFallbackValue(HttpMethod.get);
  });

  group('should fetch weather forecast data and...', () {
    late List<WeatherForecast> result;

    setUp(() async {
      // Arrange: Set up the request and response
      when(
        () => client.request(url: any(named: 'url'), method: any(named: 'method')),
      ).thenAnswer((_) async => jsonEncode(json));

      // Act: Call the use case with the input parameters
      result = await sut(inputParams);
    });

    test('return a list of WeatherForecast entities', () => expect(result, isA<List<WeatherForecast>>()));
  });
}
