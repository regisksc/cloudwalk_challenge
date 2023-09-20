import 'package:core/core.dart';

abstract class WeatherState extends Equatable {}

abstract class LoadingState extends WeatherState {}

abstract class DataState extends WeatherState {}

abstract class WeatherError extends WeatherState {
  WeatherError(this.errorMessage);
  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
