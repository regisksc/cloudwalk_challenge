import 'dart:convert';

import 'package:core/core.dart';

import '../../cities.dart';
import '../mapper/geolocation_mapper.dart';

class LocallyGeolocateCity implements GeolocateCity {
  LocallyGeolocateCity({required this.storage});

  final Read storage;

  @override
  Future<List<Geolocation>> call(GeolocationInput params) async {
    final cachedResult = await storage.read(key: params.cacheKey);
    final jsonList = jsonDecode(cachedResult) as List;
    final mapperList = jsonList.map((e) => GeolocationMapper.fromJson(e, locale: params.locale)).toList();
    return mapperList.asEntityList;
  }
}
