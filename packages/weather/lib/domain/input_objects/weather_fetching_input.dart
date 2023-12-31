import 'package:core/core.dart';

class WeatherFetchingInput extends Equatable {
  const WeatherFetchingInput({
    required this.cityName,
    required this.latitude,
    required this.longitude,
    this.locale,
  });

  final String cityName;
  final double latitude;
  final double longitude;
  final String? locale;

  @override
  List<Object?> get props => [latitude, longitude, locale];

  String get cacheKey => 'weather_${latitude}_${longitude}_${locale ?? 'en_US'}';

  bool? get stringify => true;
}
