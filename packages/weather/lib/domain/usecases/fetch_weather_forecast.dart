import 'package:core/core.dart';

import '../../weather.dart';

abstract class FetchWeatherForecast extends Usecase<List<WeatherForecast>, WeatherForcastInput> {}

class WeatherForcastInput extends Equatable {
  const WeatherForcastInput({
    required this.latitude,
    required this.longitude,
    this.locale,
  });

  final double latitude;
  final double longitude;
  final String? locale;

  @override
  List<Object?> get props => [latitude, longitude, locale];

  @override
  bool? get stringify => true;
}
