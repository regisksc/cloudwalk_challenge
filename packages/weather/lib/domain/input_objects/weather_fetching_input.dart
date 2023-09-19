import 'package:core/core.dart';

class WeatherFetchingInput extends Equatable {
  const WeatherFetchingInput({
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