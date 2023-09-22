import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather/weather.dart';

import '../../../_utils/mocks.dart';

void main() {
  late WeatherForecast mockForecast;
  late MockFetchCurrentWeather mockFetchCurrentWeather;

  setUp(() => mockFetchCurrentWeather = MockFetchCurrentWeather());
  const input = WeatherFetchingInput(latitude: 0.0, longitude: 0.0, cityName: '');

  setUpAll(() {
    registerFallbackValue(input);
    mockForecast = MockWeatherForecast();
  });

  blocTest<CurrentWeatherCubit, CurrentWeatherState>(
    'emits loading and loaded when successful',
    build: () {
      when(() => mockFetchCurrentWeather(any())).thenAnswer((_) async => mockForecast);
      return CurrentWeatherCubit(mockFetchCurrentWeather);
    },
    act: (sut) => sut.getCurrentWeather(input), // Change this line
    expect: () => [CurrentWeatherLoading(), CurrentWeatherLoaded(mockForecast)],
  );

  blocTest<CurrentWeatherCubit, CurrentWeatherState>(
    'emits loading and error when an error occurs',
    build: () {
      final mockFetchCurrentWeather = MockFetchCurrentWeather();
      when(() => mockFetchCurrentWeather(input)).thenThrow(Exception('An error occurred, please contact Admin'));
      return CurrentWeatherCubit(mockFetchCurrentWeather);
    },
    act: (sut) => sut.getCurrentWeather(input),
    expect: () => [CurrentWeatherLoading(), isA<CurrentWeatherError>()],
  );
}
