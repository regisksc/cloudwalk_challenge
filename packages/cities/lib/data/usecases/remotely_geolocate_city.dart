import 'package:core/core.dart';

import '../../cities.dart';

class RemotelyGeolocateCity implements GeolocateCity {
  RemotelyGeolocateCity(this.client);

  final HttpClient client;

  @override
  Future<City> call(City params) async {
    final city = params;

    final geolocationJson = await client.request(
      url: ApiHelper.makeUrl(
        path: ApiHelper.geolocationPath,
        queries: ApiHelper.makeGeolocationQuery(city.name),
      ),
    ) as List<Map<String, dynamic>>;

    // ignore: unnecessary_null_comparison
    if (geolocationJson == null) throw NotFoundFailure();
    final latitude = geolocationJson.first['lat'];
    final longitude = geolocationJson.first['lon'];
    if (latitude == '' || longitude == '') throw ServerFailure();
    final geolocation = Geolocation(latitude: latitude, longitude: longitude);

    return city.copyWith(geolocation: geolocation);
  }
}
