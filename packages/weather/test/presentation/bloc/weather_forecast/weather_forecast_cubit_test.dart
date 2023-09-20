import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather/weather.dart';

import '../../../_utils/mocks.dart';

class MockFetchWeatherForecast extends Mock implements Usecase<List<WeatherForecast>, WeatherFetchingInput> {}

void main() {
  late List<WeatherForecast> mockForecasts;
  late MockFetchWeatherForecast mockFetchWeatherForecastRemotely;
  late MockFetchWeatherForecast mockFetchWeatherForecastLocally;

  setUp(() {
    mockFetchWeatherForecastRemotely = MockFetchWeatherForecast();
    mockFetchWeatherForecastLocally = MockFetchWeatherForecast();
    mockForecasts = List.generate(40, (index) => MockWeatherForecast());
  });

  group('remote tests- ', () {
    const input = WeatherFetchingInput(latitude: 0.0, longitude: 0.0, cityName: '');

    blocTest<WeatherForecastCubit, WeatherForecastState>(
      'emits loading and loaded when successful',
      build: () {
        when(() => mockFetchWeatherForecastLocally(input)).thenAnswer((_) async => mockForecasts);
        return WeatherForecastCubit(mockFetchWeatherForecastRemotely, mockFetchWeatherForecastLocally);
      },
      act: (sut) => sut.getWeatherForecast(input, local: true),
      expect: () => [
        WeatherForecastLoading(),
        WeatherForecastLoaded(mockForecasts),
      ],
    );

    blocTest<WeatherForecastCubit, WeatherForecastState>(
      'emits loading and error when an error occurs',
      build: () {
        when(() => mockFetchWeatherForecastLocally(input))
            .thenThrow(Exception());
        return WeatherForecastCubit(mockFetchWeatherForecastRemotely, mockFetchWeatherForecastLocally);
      },
      act: (sut) => sut.getWeatherForecast(input, local: true),
      expect: () => [
        WeatherForecastLoading(),
        isA<WeatherForecastError>(),
      ],
    );
  });
  
  group('local tests - ', () {
    const input = WeatherFetchingInput(latitude: 0.0, longitude: 0.0, cityName: '');

    blocTest<WeatherForecastCubit, WeatherForecastState>(
      'emits loading and loaded when successful',
      build: () {
        when(() => mockFetchWeatherForecastRemotely(input)).thenAnswer((_) async => mockForecasts);
        return WeatherForecastCubit(mockFetchWeatherForecastRemotely, mockFetchWeatherForecastLocally);
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
        when(() => mockFetchWeatherForecastRemotely(input))
            .thenThrow(Exception('An error occurred, please contact Admin'));
        return WeatherForecastCubit(mockFetchWeatherForecastRemotely, mockFetchWeatherForecastLocally);
      },
      act: (sut) => sut.getWeatherForecast(input),
      expect: () => [
        WeatherForecastLoading(),
        isA<WeatherForecastError>(),
      ],
    );
  });
}
