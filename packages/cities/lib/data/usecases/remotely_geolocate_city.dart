import 'dart:convert';

import 'package:core/core.dart';

import '../../cities.dart';
import '../mapper/geolocation_mapper.dart';

class RemotelyGeolocateCity implements GeolocateCity {
  RemotelyGeolocateCity(this.client);

  final HttpClient client;

  @override
  Future<List<Geolocation>> call(GeolocationInput params) async {
    final result = await client.request(
      url: ApiHelper.makeUrl(
        path: ApiHelper.geolocationPath,
        queries: ApiHelper.makeGeolocationQuery(query: params.cityName, locale: params.locale),
      ),
    );
    final listData = jsonDecode(result) as List;
    final mapperList = listData.map((e) => GeolocationMapper.fromJson(e, locale: params.locale)).toList();
    return mapperList.asEntityList;
  }
}
