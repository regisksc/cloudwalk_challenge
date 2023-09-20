import '../../../weather.dart';

abstract class WeatherForecastState extends WeatherState {}

class WeatherForecastLoading extends WeatherForecastState implements LoadingState {
  @override
  List<Object?> get props => [];
}

class WeatherForecastLoaded extends WeatherForecastState implements DataState {
  WeatherForecastLoaded(this.forecasts);
  final List<WeatherForecast> forecasts;

  @override
  List<Object?> get props => [forecasts];
}

class WeatherForecastError extends WeatherForecastState implements WeatherError {
  WeatherForecastError({required this.message});
  final String message;
  @override
  String get errorMessage => message;
  @override
  List<Object?> get props => [message];
}
