import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../weather.dart';

class WeatherForecastCubit extends Cubit<WeatherForecastState> {
  WeatherForecastCubit(Usecase<List<WeatherForecast>, WeatherFetchingInput> fetchWeatherForecast)
      : _fetchWeatherForecast = fetchWeatherForecast,
        super(WeatherForecastLoading());

  final Usecase<List<WeatherForecast>, WeatherFetchingInput> _fetchWeatherForecast;

  Future getWeatherForecast(WeatherFetchingInput input) async {
    emit(WeatherForecastLoading());

    try {
      final forecasts = await _fetchWeatherForecast(input);
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
