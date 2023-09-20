import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../weather.dart';

class CurrentWeatherCubit extends Cubit<CurrentWeatherState> {
  CurrentWeatherCubit(this._fetchCurrentWeatherRemotely, this._fetchCurrentWeatherLocally)
      : super(CurrentWeatherLoading());

  final Usecase<WeatherForecast, WeatherFetchingInput> _fetchCurrentWeatherRemotely;
  final Usecase<WeatherForecast, WeatherFetchingInput> _fetchCurrentWeatherLocally;

  Future getCurrentWeather(WeatherFetchingInput input, {bool local = false}) async {
    emit(CurrentWeatherLoading());

    try {
      final usecase = local ? _fetchCurrentWeatherLocally : _fetchCurrentWeatherRemotely;
      final weather = await usecase(input);
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
