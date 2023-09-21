import '../../cities.dart';

class GeolocationMapper {
  GeolocationMapper({
    required this.name,
    required this.lat,
    required this.lon,
    this.localName,
    this.country,
    this.state,
  });

  factory GeolocationMapper.fromJson(Map<String, dynamic> json, {String? locale}) {
    final locationCountry = locale?.split('_') ?? 'en';
    _modifiedWhen = json['dt'] != null ? DateTime(json['dt']) : DateTime.now().toUtc();
    return GeolocationMapper(
      name: json['name'].toString(),
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      localName: json['local_names'] != null ? json['local_names'][locationCountry] : null,
      country: json['country'].toString(),
      state: json['state'].toString(),
    );
  }

  final String name;
  final double lat;
  final double lon;
  final String? localName;
  final String? country;
  final String? state;
  static DateTime _modifiedWhen = DateTime.now().toUtc();

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lat': lat,
      'lon': lon,
      'country': country,
      'state': state,
      'dt': _modifiedWhen.toUtc().millisecondsSinceEpoch,
    };
  }
}

extension GeolocationMapperExtension on GeolocationMapper {
  Geolocation get asEntity => Geolocation(
        name: name,
        lat: lat,
        lon: lon,
        localName: localName,
        country: country,
        state: state,
        modifiedWhen: GeolocationMapper._modifiedWhen,
      );
}

extension GeolocationMapperListExtension on List<GeolocationMapper> {
  List<Geolocation> get asEntityList => map((e) => Geolocation(
        name: e.name,
        lat: e.lat,
        lon: e.lon,
        localName: e.localName,
        country: e.country,
        state: e.state,
        modifiedWhen: GeolocationMapper._modifiedWhen,
      )).toList();
}
