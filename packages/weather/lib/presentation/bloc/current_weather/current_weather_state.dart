import '../../../weather.dart';

abstract class CurrentWeatherState extends WeatherState {}

class CurrentWeatherLoading extends CurrentWeatherState implements LoadingState {
  @override
  List<Object?> get props => [];
}

class CurrentWeatherLoaded extends CurrentWeatherState implements DataState {
  CurrentWeatherLoaded(this.weather);
  final WeatherForecast weather;

  @override
  List<Object?> get props => [weather];
}

class CurrentWeatherError extends CurrentWeatherState implements WeatherError {
  CurrentWeatherError({required this.message});
  final String message;
  @override
  String get errorMessage => message;
  @override
  List<Object?> get props => [message];
}
