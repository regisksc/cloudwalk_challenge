import 'package:core/core.dart';
import 'package:weather/weather.dart';

import '../exports/exports.dart';

class WeatherBlocFactory {
  WeatherBlocFactory._();
  static MultiBlocProvider instance({
    required HttpClient httpAdapter,
    required Storage storage,
    required WeatherFetchingInput args,
  }) {
    final remoteCurrent = ErrorHandleDecorator<WeatherForecast, WeatherFetchingInput>(
      RemotelyFetchCurrentWeather(client: httpAdapter, storage: storage),
    );

    final remoteFiveDays = ErrorHandleDecorator<List<WeatherForecast>, WeatherFetchingInput>(
      RemotelyFetchWeatherForecast(client: httpAdapter, storage: storage),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: CurrentWeatherCubit(remoteCurrent)),
        BlocProvider.value(value: WeatherForecastCubit(remoteFiveDays)),
      ],
      child: WeatherForecastPage(
        input: WeatherFetchingInput(
          cityName: args.cityName,
          latitude: args.latitude,
          longitude: args.longitude,
          locale: args.locale,
        ),
      ),
    );
  }
}
