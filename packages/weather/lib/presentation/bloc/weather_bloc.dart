import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../weather.dart';
import '../presentation.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit({
    required this.fetchCurrentWeather,
    required this.fetchWeatherForecast,
  }) : super(WeatherInitial());

  final FetchCurrentWeather fetchCurrentWeather;
  final FetchWeatherForecast fetchWeatherForecast;

  Future getCurrentWeather(WeatherFetchingInput input) async {
    emit(CurrentWeatherLoading()); // Emit loading event first

    try {
      final weather = await fetchCurrentWeather(input);
      emit(CurrentWeatherLoaded(weather)); // Emit loaded event after successful fetch
    } catch (e) {
      emit(WeatherError(_returnErrorMessage(e))); // Handle error and emit error event
    }
  }

  Future getWeatherForecast(WeatherFetchingInput input) async {
    emit(WeatherForecastLoading()); // Emit loading event first

    try {
      final forecasts = await fetchWeatherForecast(input);
      emit(WeatherForecastLoaded(forecasts)); // Emit loaded event after successful fetch
    } catch (e) {
      emit(WeatherError(_returnErrorMessage(e))); // Handle error and emit error event
    }
  }

  String _returnErrorMessage(Object e) {
    if (e is ServerFailure) return 'Our services are unstable, please try again in a few minutes';
    if (e is StorageFailure) return 'There was an error reading your data offline';
    return 'An error occured, please contact Admin';
  }
}
