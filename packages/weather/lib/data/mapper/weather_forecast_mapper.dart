import '../../weather.dart';

class WeatherForecastMapper {
  WeatherForecastMapper({
    required this.time,
    required this.tempMin,
    required this.tempMax,
    required this.weatherDescription,
    required this.windSpeed,
  });

  factory WeatherForecastMapper.fromJson(Map<String, dynamic> json) {
    return WeatherForecastMapper(
      time: DateTime.fromMillisecondsSinceEpoch((json['dt'] as int) * 1000).formatted,
      tempMin: Temperature(value: json['main']['temp_min'] as num),
      tempMax: Temperature(value: json['main']['temp_max'] as num),
      weatherDescription:
          ((json['weather'] as List<dynamic>).firstOrNull as Map<String, dynamic>)['description'] ?? 'N/A',
      windSpeed: WindSpeed(value: json['wind']['speed'] as num),
    );
  }

  final String time;
  final Temperature tempMin;
  final Temperature tempMax;
  final String weatherDescription;
  final WindSpeed windSpeed;
}




