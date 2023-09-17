import 'package:core/core.dart';

import '../../weather.dart';

abstract class FetchWeatherForecast extends Usecase<List<WeatherForecast>, WeatherForcastInput> {}

class WeatherForcastInput extends Equatable {
  const WeatherForcastInput({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  @override
  List<Object?> get props => [latitude, longitude];

  @override
  bool? get stringify => true;
}
