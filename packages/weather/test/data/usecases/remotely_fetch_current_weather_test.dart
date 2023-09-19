import 'dart:convert';

import 'package:core/core.dart';
import 'package:core/exports/exports.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather/data/usecases/remotely_fetch_current_weather.dart';
import 'package:weather/weather.dart';

import '../../_fixtures/json_fixture_reader.dart';

class MockClient extends Mock implements HttpClient {}

void main() {
  late HttpClient client;
  late RemotelyFetchCurrentWeather sut;

  late WeatherFetchingInput inputParams;

  final jsonString = fixture('sao_paulo_current_weather_fixture.json');
  final json = jsonDecode(jsonString) as Map<String, dynamic>;

  setUp(() {
    inputParams = WeatherFetchingInput(
      latitude: faker.geo.latitude(),
      longitude: faker.geo.longitude(),
    );
    client = MockClient();
    sut = RemotelyFetchCurrentWeather(client);
  });

  setUpAll(() {
    registerFallbackValue(HttpMethod.get);
  });

  group('should fetch current weather forecast data and...', () {
    late WeatherForecast result;

    setUp(() async {
      // Arrange: Set up the request and response
      when(
        () => client.request(url: any(named: 'url'), method: any(named: 'method')),
      ).thenAnswer((_) async => jsonEncode(json));

      // Act: Call the use case with the input parameters
      result = await sut(inputParams);
    });

    test('return one WeatherForecast entity', () => expect(result, isA<WeatherForecast>()));
  });
}
