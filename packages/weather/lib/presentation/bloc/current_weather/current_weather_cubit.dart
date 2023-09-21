import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../weather.dart';

class CurrentWeatherCubit extends Cubit<CurrentWeatherState> {
  CurrentWeatherCubit(Usecase<WeatherForecast, WeatherFetchingInput> fetchCurrentWeather)
      : _fetchCurrentWeather = fetchCurrentWeather,
        super(CurrentWeatherLoading());

  final Usecase<WeatherForecast, WeatherFetchingInput> _fetchCurrentWeather;

  Future getCurrentWeather(WeatherFetchingInput input) async {
    emit(CurrentWeatherLoading());

    try {
      final weather = await _fetchCurrentWeather(input);
      emit(CurrentWeatherLoaded(weather));
    } catch (e) {
      String errorMessage;
      if (e is ServerFailure) errorMessage = 'Our services are unstable, please try again in a few minutes';
      if (e is StorageFailure) errorMessage = 'There was an error reading your data offline';
      errorMessage = 'An error occured, please contact Admin';
      emit(CurrentWeatherError(message: errorMessage));
    }
  }
}
