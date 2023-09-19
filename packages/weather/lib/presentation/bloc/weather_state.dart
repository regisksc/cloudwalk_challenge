import 'package:core/core.dart';

import '../../weather.dart';

abstract class WeatherState extends Equatable {}

class WeatherInitial extends WeatherState {
  @override
  List<Object?> get props => [];
}

class CurrentWeatherLoading extends WeatherState {
  @override
  List<Object?> get props => [];
}

class CurrentWeatherLoaded extends WeatherState {
  CurrentWeatherLoaded(this.weather);
  final WeatherForecast weather;

  @override
  List<Object?> get props => [weather];
}

class WeatherForecastLoading extends WeatherState {
  @override
  List<Object?> get props => [];
}

class WeatherForecastLoaded extends WeatherState {
  WeatherForecastLoaded(this.forecasts);
  final List<WeatherForecast> forecasts;

  @override
  List<Object?> get props => [forecasts];
}

class WeatherError extends WeatherState {
  WeatherError(this.errorMessage);
  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}

class CurrentWeatherError extends WeatherError {
  CurrentWeatherError(super.errorMessage);
}

class WeatherForecastError extends WeatherError {
  WeatherForecastError(super.errorMessage);
}
