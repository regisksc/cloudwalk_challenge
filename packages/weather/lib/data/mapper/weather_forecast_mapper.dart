import '../../weather.dart';

class WeatherForecastMapper {
  WeatherForecastMapper({
    required this.time,
    required this.tempMin,
    required this.tempMax,
    required this.weatherDescription,
    required this.windSpeed,
    DateTime? modifiedWhen,
  }) : _modifiedWhen = modifiedWhen ?? DateTime.now().toUtc();

  factory WeatherForecastMapper.fromJson(Map<String, dynamic> json, {String? locale}) {
    return WeatherForecastMapper(
      time: ForecastTime(unixTimestamp: json['dt'] as int, locale: locale),
      tempMin: Temperature(value: json['main']['temp_min'] as num),
      tempMax: Temperature(value: json['main']['temp_max'] as num),
      weatherDescription:
          ((json['weather'] as List<dynamic>).firstOrNull as Map<String, dynamic>)['description'] ?? 'N/A',
      windSpeed: WindSpeed(value: json['wind']['speed'] as num),
    );
  }

  final ForecastTime time;
  final Temperature tempMin;
  final Temperature tempMax;
  final String weatherDescription;
  final WindSpeed windSpeed;
  final DateTime _modifiedWhen;

  DateTime get modifiedWhen => _modifiedWhen;

  WeatherForecastMapper copyWith({DateTime? modifiedWhen}) {
    return WeatherForecastMapper(
      time: time,
      tempMin: tempMin,
      tempMax: tempMax,
      weatherDescription: weatherDescription,
      windSpeed: windSpeed,
      modifiedWhen: modifiedWhen ?? _modifiedWhen,
    );
  }

  Map<String, dynamic> toJson() => {
        'dt': _modifiedWhen,
        'main': {'temp_min': tempMin.value, 'temp_max': tempMax.value},
        'weather': [
          {'description': weatherDescription}
        ],
        'wind': {'speed': windSpeed.value},
      };
}

extension WeatherForecastMapperExtensions on WeatherForecastMapper {
  WeatherForecast get asEntity {
    return WeatherForecast(
      time: time,
      tempMin: tempMin,
      tempMax: tempMax,
      weatherDescription: weatherDescription,
      windSpeed: windSpeed,
      modifiedWhen: _modifiedWhen,
    );
  }
}

extension WeatherForecastMapperListExtensions on List<WeatherForecastMapper> {
  List<WeatherForecast> get asEntities => map((e) => e.asEntity).toList();
}
