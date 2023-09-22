import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core/core.dart';
import 'package:weather/weather.dart';

import '../exports/exports.dart';

class WeatherBlocFactory {
  // coverage:ignore-line
  WeatherBlocFactory._();
  static MultiBlocProvider instance({
    required HttpClient httpAdapter,
    required Storage storage,
    required WeatherFetchingInput args,
  }) {
    final connectivity = Connectivity();
    final decoratedFetchCurrentWeatherUsecase = ConnectionHandleDecorator(
      cacheDecoratee: LocallyFetchCurrentWeather(storage),
      remoteDecoratee: ErrorHandleDecorator<WeatherForecast, WeatherFetchingInput>(
        RemotelyFetchCurrentWeather(client: httpAdapter, storage: storage),
      ),
      connectivity: connectivity,
    );

    final decoratedFetchWeatherForecastUsecase = ConnectionHandleDecorator(
      cacheDecoratee: LocallyFetchWeatherForecast(storage),
      remoteDecoratee: ErrorHandleDecorator<List<WeatherForecast>, WeatherFetchingInput>(
        RemotelyFetchWeatherForecast(client: httpAdapter, storage: storage),
      ),
      connectivity: connectivity,
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: CurrentWeatherCubit(decoratedFetchCurrentWeatherUsecase)),
        BlocProvider.value(value: WeatherForecastCubit(decoratedFetchWeatherForecastUsecase)),
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
