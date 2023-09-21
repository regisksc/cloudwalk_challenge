import 'package:core/domain/domain.dart';

import '../../weather.dart';

class WeatherForecast extends Entity {
  WeatherForecast({
    required this.time,
    required this.tempMin,
    required this.tempMax,
    required this.weatherDescription,
    required this.windSpeed,
    required DateTime modifiedWhen,
  }) : super(modifiedWhen);

  static WeatherForecast get empty => WeatherForecast(
        tempMax: Temperature(value: 0),
        time: ForecastTime(unixTimestamp: 0),
        tempMin: Temperature(value: 0),
        weatherDescription: '',
        windSpeed: WindSpeed(value: 0),
        modifiedWhen: DateTime.now().toUtc(),
      );

  final ForecastTime time;
  final Temperature tempMin;
  final Temperature tempMax;
  final String weatherDescription;
  final WindSpeed windSpeed;

  @override
  List<Object?> get props => [time, tempMin, tempMax, weatherDescription, windSpeed];
}
