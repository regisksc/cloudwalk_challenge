import 'package:core/core.dart';

class Geolocation extends Entity {
  Geolocation({
    required this.latitude,
    required this.longitude,
  }) {
    if (!_isValidLatitude(latitude)) throw ArgumentError('Invalid latitude');
    if (!_isValidLongitude(longitude)) throw ArgumentError('Invalid longitude');
  }

  final double latitude;
  final double longitude;

  @override
  List<Object?> get props => [latitude, longitude];

  Geolocation copyWith({
    double? latitude,
    double? longitude,
  }) {
    if (latitude == null && longitude == null) return this;
    final entity = Geolocation(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
    entity.markAsModified();
    return entity;
  }

  bool _isValidLatitude(double? value) {
    if (value == null) return false;
    return latitude >= -90.0 && latitude <= 90.0;
  }

  bool _isValidLongitude(double? value) {
    if (value == null) return false;
    return longitude >= -180.0 && longitude <= 180.0;
  }
}
