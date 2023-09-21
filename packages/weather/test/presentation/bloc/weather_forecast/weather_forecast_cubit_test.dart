import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather/weather.dart';

import '../../../_utils/mocks.dart';

class MockFetchWeatherForecast extends Mock implements Usecase<List<WeatherForecast>, WeatherFetchingInput> {}

void main() {
  late List<WeatherForecast> mockForecasts;
  late MockFetchWeatherForecast mockFetchWeatherForecast;

  setUp(() {
    mockFetchWeatherForecast = MockFetchWeatherForecast();
    mockForecasts = List.generate(40, (index) => MockWeatherForecast());
  });

  const input = WeatherFetchingInput(latitude: 0.0, longitude: 0.0, cityName: '');
  setUpAll(() {
    registerFallbackValue(input);
  });

  blocTest<WeatherForecastCubit, WeatherForecastState>(
    'emits loading and loaded when successful',
    build: () {
      when(() => mockFetchWeatherForecast(any())).thenAnswer((_) async => mockForecasts);
      return WeatherForecastCubit(mockFetchWeatherForecast);
    },
    act: (sut) => sut.getWeatherForecast(input),
    expect: () => [
      WeatherForecastLoading(),
      WeatherForecastLoaded(mockForecasts),
    ],
  );

  blocTest<WeatherForecastCubit, WeatherForecastState>(
    'emits loading and error when an error occurs',
    build: () {
      when(() => mockFetchWeatherForecast(input)).thenThrow(Exception());
      return WeatherForecastCubit(mockFetchWeatherForecast);
    },
    act: (sut) => sut.getWeatherForecast(input),
    expect: () => [
      WeatherForecastLoading(),
      isA<WeatherForecastError>(),
    ],
  );
}
