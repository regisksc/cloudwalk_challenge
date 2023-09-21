import 'dart:convert';

import 'package:core/exports/exports.dart';

import '../../weather.dart';

class RemotelyFetchWeatherForecast implements FetchWeatherForecast {
  RemotelyFetchWeatherForecast({required this.client, required this.storage});

  final HttpClient client;
  final Write storage;
  Future<List<WeatherForecast>> call(WeatherFetchingInput params) async {
    final result = await client.request(
      url: ApiHelper.makeUrl(
        path: WeatherConstants.forecastPath,
        queries: ApiHelper.makeForecastQuery(
          lat: params.latitude.toString(),
          lon: params.longitude.toString(),
          locale: params.locale,
        ),
      ),
    );
    final json = jsonDecode(jsonEncode(result)) as Map<String, dynamic>;
    final listData = json['list'] as List<dynamic>;
    final mapperList = listData.map((e) => WeatherForecastMapper.fromJson(e)).toList();
    storage.write(key: 'list_${params.cacheKey}', value: jsonEncode(mapperList.map((e) => e.toJson()).toList()));
    return mapperList.asEntities;
  }
}
