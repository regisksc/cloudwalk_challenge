import 'dart:convert';

import 'package:core/core.dart';

import '../../weather.dart';

class LocallyFetchWeatherForecast implements FetchWeatherForecast {
  LocallyFetchWeatherForecast(this.storage);

  final Read storage;

  @override
  Future<List<WeatherForecast>> call(WeatherFetchingInput params) async {
    final cachedResult = await storage.read(key: 'list_${params.cacheKey}');

    final Map<String, dynamic> cachedData = jsonDecode(cachedResult) as Map<String, dynamic>;
    final List forecastsData = jsonDecode(cachedData['list']);
    final forecasts = forecastsData
        .map((json) => WeatherForecastMapper.fromJson(
              json as Map<String, dynamic>,
            ).asEntity)
        .toList();

    return forecasts;
  }
}
