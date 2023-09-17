import 'package:core/domain/domain.dart';

import '../../weather.dart';

class WeatherForecast extends Entity {
  WeatherForecast({
    required this.time,
    required this.tempMin,
    required this.tempMax,
    required this.weatherDescription,
    required this.windSpeed,
  });

  final String time;
  final Temperature tempMin;
  final Temperature tempMax;
  final String weatherDescription;
  final WindSpeed windSpeed;

  @override
  List<Object?> get props => [time, tempMin, tempMax, weatherDescription, windSpeed];
}
