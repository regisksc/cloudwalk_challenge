import 'package:core/core.dart';

class Geolocation extends Entity {
  Geolocation({
    required this.latitude,
    required this.longitude,
  }) {
    if (!_isValidLatitude(latitude)) throw ArgumentError('Invalid latitude');
    if (!_isValidLongitude(longitude)) throw ArgumentError('Invalid longitude');
  }

  final String latitude;
  final String longitude;

  @override
  List<Object?> get props => [latitude, longitude];

  Geolocation copyWith({
    String? latitude,
    String? longitude,
  }) {
    return Geolocation(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  bool _isValidLatitude(String? value) {
    if (value == null) return false;
    final double? latitude = double.tryParse(value);
    return latitude != null && latitude >= -90.0 && latitude <= 90.0;
  }

  bool _isValidLongitude(String? value) {
    if (value == null) return false;
    final double? longitude = double.tryParse(value);
    return longitude != null && longitude >= -180.0 && longitude <= 180.0;
  }
}
