import 'package:core/core.dart';

class Geolocation extends Entity {
  Geolocation({
    required this.name,
    this.lat,
    this.lon,
    this.localName,
    this.country,
    this.state,
    required DateTime modifiedWhen,
  }) : super(modifiedWhen) {
    final lonInstancedOnly = lat == null && lon != null;
    final latInstancedOnly = lon == null && lat != null;
    if (latInstancedOnly || lonInstancedOnly) throw ArgumentError('Geolocation not properly initialized');
    if (!_isValidLatitude(lat)) throw ArgumentError('Invalid latitude');
    if (!_isValidLongitude(lon)) throw ArgumentError('Invalid longitude');
  }

  final String name;
  final double? lat;
  final double? lon;
  final String? localName;
  final String? country;
  final String? state;

  bool _isValidLatitude(double? value) {
    return (value ?? 0) >= -90.0 && (value ?? 0) <= 90.0;
  }

  bool _isValidLongitude(double? value) {
    return (value ?? 0) >= -180.0 && (value ?? 0) <= 180.0;
  }

  bool get isLoading => lat == null && lon == null;

  @override
  List<Object?> get props => [name, lat, lon, country, state];
}
