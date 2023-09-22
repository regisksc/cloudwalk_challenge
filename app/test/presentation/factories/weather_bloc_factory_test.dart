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
  group('WeatherBlocFactory', () {
    test('should return MultiBlocProvider with CurrentWeatherCubit and WeatherForecastCubit', () {
      // Arrange
      final mockHttpClient = MockHttpClient();
      final mockStorage = MockStorage();

      const args = WeatherFetchingInput(
        cityName: 'Example City',
        latitude: 12.345,
        longitude: 67.890,
        locale: 'en',
      );

      final factory = WeatherBlocFactory.instance(
        httpAdapter: mockHttpClient,
        storage: mockStorage,
        args: args,
      );

      // Assert
      expect(factory, isA<MultiBlocProvider>());
    });
  });
}
