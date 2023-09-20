import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../weather.dart';

class WeatherForecastCubit extends Cubit<WeatherForecastState> {
  WeatherForecastCubit(
    this._fetchWeatherForecastRemotely,
    this._fetchWeatherForecastLocally,
  ) : super(WeatherForecastLoading());

  final Usecase<List<WeatherForecast>, WeatherFetchingInput> _fetchWeatherForecastRemotely;
  final Usecase<List<WeatherForecast>, WeatherFetchingInput> _fetchWeatherForecastLocally;

  Future getWeatherForecast(WeatherFetchingInput input, {bool local = false}) async {
    emit(WeatherForecastLoading());

    try {
      final forecasts = await (local ? _fetchWeatherForecastLocally(input) : _fetchWeatherForecastRemotely(input));
      emit(WeatherForecastLoaded(forecasts));
    } catch (e) {
      String errorMessage;
      if (e is ServerFailure) errorMessage = 'Our services are unstable, please try again in a few minutes';
      if (e is StorageFailure) errorMessage = 'There was an error reading your data offline';
      errorMessage = 'An error occured, please contact Admin';
      emit(WeatherForecastError(message: errorMessage));
    }
  }
}
