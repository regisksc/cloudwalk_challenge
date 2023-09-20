import 'package:core/core.dart';

class GeolocationInput extends Equatable {
  const GeolocationInput({
    required this.cityName,
    this.locale,
  });

  final String cityName;
  final String? locale;

  @override
  List<Object?> get props => [cityName, locale];

  String get cacheKey => 'geolocation_${cityName}_${locale ?? 'en_US'}';

  bool? get stringify => true;
}
