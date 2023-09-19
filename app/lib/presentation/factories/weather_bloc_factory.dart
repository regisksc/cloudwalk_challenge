import 'package:core/core.dart';
import 'package:weather/weather.dart';

import '../exports/exports.dart';

class WeatherBlocFactory {
  WeatherBlocFactory._();
  static MultiBlocProvider instance({
    required HttpClient httpAdapter,
    required Storage storage,
  }) {
    final remoteCurrent = ErrorHandleDecorator<WeatherForecast, WeatherFetchingInput>(
      RemotelyFetchCurrentWeather(client: httpAdapter, storage: storage),
    );

    final remoteFiveDays = ErrorHandleDecorator<List<WeatherForecast>, WeatherFetchingInput>(
      RemotelyFetchWeatherForecast(client: httpAdapter, storage: storage),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: WeatherCubit(
            fetchCurrentWeather: remoteCurrent,
            fetchWeatherForecast: remoteFiveDays,
          ),
        ),
      ],
      child: const WeatherForecastPage(
        input: WeatherFetchingInput(latitude: 0, longitude: 0),
        title: 'Liverpool',
      ),
    );
  }
}
