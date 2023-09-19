import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../weather.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit({
    required this.fetchCurrentWeather,
    required this.fetchWeatherForecast,
  }) : super(WeatherInitial());

  final Usecase<WeatherForecast, WeatherFetchingInput> fetchCurrentWeather;
  final Usecase<List<WeatherForecast>, WeatherFetchingInput> fetchWeatherForecast;

  Future getCurrentWeather(WeatherFetchingInput input) async {
    emit(CurrentWeatherLoading());

    try {
      final weather = await fetchCurrentWeather(input);
      emit(CurrentWeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(_returnErrorMessage(e)));
    }
  }

  Future getWeatherForecast(WeatherFetchingInput input) async {
    emit(WeatherForecastLoading());

    try {
      final forecasts = await fetchWeatherForecast(input);
      emit(WeatherForecastLoaded(forecasts));
    } catch (e) {
      emit(WeatherError(_returnErrorMessage(e)));
    }
  }

  String _returnErrorMessage(Object e) {
    if (e is ServerFailure) return 'Our services are unstable, please try again in a few minutes';
    if (e is StorageFailure) return 'There was an error reading your data offline';
    return 'An error occured, please contact Admin';
  }
}
