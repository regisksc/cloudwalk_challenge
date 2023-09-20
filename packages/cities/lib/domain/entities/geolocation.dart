import 'package:core/core.dart';

class Geolocation extends Entity {
  Geolocation({
    required this.name,
    required this.lat,
    required this.lon,
    required this.localName,
    required this.country,
    required this.state,
  }) {
    if (!_isValidLatitude(lat)) throw ArgumentError('Invalid latitude');
    if (!_isValidLongitude(lon)) throw ArgumentError('Invalid longitude');
  }

  final String name;
  final double lat;
  final double lon;
  final String? localName;
  final String? country;
  final String? state;

  bool _isValidLatitude(double? value) {
    if (value == null) return false;
    return lat >= -90.0 && lat <= 90.0;
  }

  bool _isValidLongitude(double? value) {
    if (value == null) return false;
    return lon >= -180.0 && lon <= 180.0;
  }

  @override
  List<Object?> get props => [name, lat, lon, country, state];
}
