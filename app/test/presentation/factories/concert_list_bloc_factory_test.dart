import 'package:cloudwalk_challenge/presentation/presentation.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:weather/weather.dart';

import '../../_utils/mocks.dart';

class MockLocallyFetchCurrentWeather extends Mock implements LocallyFetchCurrentWeather {}

class MockRemotelyFetchCurrentWeather extends Mock implements RemotelyFetchCurrentWeather {}

class MockLocallyFetchWeatherForecast extends Mock implements LocallyFetchWeatherForecast {}

class MockRemotelyFetchWeatherForecast extends Mock implements RemotelyFetchWeatherForecast {}

void main() {
  group('ConcertListBlocFactory', () {
    test('should return MultiBlocProvider with CurrentWeatherCubit and WeatherForecastCubit', () {
      // Arrange
      final mockHttpClient = MockHttpClient();
      final mockStorage = MockStorage();

      const page = ConcertListPage();

      final factory = ConcertListBlocFactory.instance(
        httpAdapter: mockHttpClient,
        storage: mockStorage,
        page: page,
      );

      // Assert
      expect(factory, isA<MultiBlocProvider>());
    });
  });
}
