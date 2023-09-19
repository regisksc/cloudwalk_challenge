import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather/weather.dart';

class MockFetchCurrentWeather extends Mock implements FetchCurrentWeather {}

class MockFetchWeatherForecast extends Mock implements FetchWeatherForecast {}

class MockWeatherForecast extends Mock implements WeatherForecast {}

void main() {
  late FetchCurrentWeather mockFetchCurrentWeather;
  late FetchWeatherForecast mockFetchWeatherForecast;
  late WeatherForecast mockWeatherForecast;

  setUp(() {
    mockFetchCurrentWeather = MockFetchCurrentWeather();
    mockFetchWeatherForecast = MockFetchWeatherForecast();
    mockWeatherForecast = MockWeatherForecast();
  });

  const input = WeatherFetchingInput(latitude: 0.0, longitude: 0.0);

  group('WeatherCubit', () {
    late WeatherCubit cubit;

    setUp(() {
      cubit = WeatherCubit(
        fetchCurrentWeather: mockFetchCurrentWeather,
        fetchWeatherForecast: mockFetchWeatherForecast,
      );
    });

    blocTest<WeatherCubit, WeatherState>(
      'emits [CurrentWeatherLoading, CurrentWeatherLoaded] on success',
      build: () {
        when(() => mockFetchCurrentWeather(input)).thenAnswer((_) async => mockWeatherForecast);
        return cubit;
      },
      act: (cubit) => cubit.getCurrentWeather(input),
      expect: () => [
        CurrentWeatherLoading(),
        CurrentWeatherLoaded(mockWeatherForecast),
      ],
    );

    blocTest<WeatherCubit, WeatherState>(
      'emits [CurrentWeatherLoading, WeatherError] on failure',
      build: () {
        when(() => mockFetchCurrentWeather(input)).thenThrow(Exception('Some error'));
        return cubit;
      },
      act: (cubit) => cubit.getCurrentWeather(input),
      expect: () => [
        CurrentWeatherLoading(),
        isA<WeatherError>(),
      ],
    );

    blocTest<WeatherCubit, WeatherState>(
      'emits [WeatherForecastLoading, WeatherForecastLoaded] on success',
      build: () {
        final forecasts = List<WeatherForecast>.generate(5, (e) => mockWeatherForecast);
        when(() => mockFetchWeatherForecast(input)).thenAnswer((_) async => forecasts);
        return cubit;
      },
      act: (cubit) => cubit.getWeatherForecast(input),
      expect: () => [
        WeatherForecastLoading(),
        WeatherForecastLoaded(List<WeatherForecast>.filled(5, mockWeatherForecast)),
      ],
    );

    blocTest<WeatherCubit, WeatherState>(
      'emits [WeatherForecastLoading, WeatherError] on failure',
      build: () {
        when(() => mockFetchWeatherForecast(input)).thenThrow(Exception('Some error'));
        return cubit;
      },
      act: (cubit) => cubit.getWeatherForecast(input),
      expect: () => [
        WeatherForecastLoading(),
        isA<WeatherError>(),
      ],
    );
  });
}
