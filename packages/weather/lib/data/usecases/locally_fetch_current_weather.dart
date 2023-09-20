import 'dart:convert';

import 'package:core/core.dart';

import '../../weather.dart';

class LocallyFetchCurrentWeather implements FetchCurrentWeather {
  LocallyFetchCurrentWeather(this.storage);

  final Read storage;

  @override
  Future<WeatherForecast> call(WeatherFetchingInput params) async {
    final cachedResult = await storage.read(key: params.cacheKey);
    final json = jsonDecode(jsonEncode(cachedResult)) as Map<String, dynamic>;
    return WeatherForecastMapper.fromJson(json).asEntity;
  }
}
