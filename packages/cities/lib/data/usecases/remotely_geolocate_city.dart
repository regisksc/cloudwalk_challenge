import 'dart:convert';

import 'package:core/core.dart';

import '../../cities.dart';

class RemotelyGeolocateCity implements GeolocateCity {
  RemotelyGeolocateCity({
    required this.client,
    required this.storage,
  });

  final HttpClient client;
  final Write storage;

  @override
  Future<List<Geolocation>> call(GeolocationInput params) async {
    final result = await client.request(
      url: ApiHelper.makeUrl(
        path: ApiHelper.geolocationPath,
        queries: ApiHelper.makeGeolocationQuery(query: params.cityName, locale: params.locale),
      ),
    );
    final listData = jsonDecode(jsonEncode(result)) as List;
    final mapperList = listData.map((e) => GeolocationMapper.fromJson(e, locale: params.locale)).toList();
    storage.write(key: params.cacheKey, value: jsonEncode(mapperList.map((e) => e.toJson()).toList()));
    return mapperList.asEntities;
  }
}
