import 'dart:convert';

import 'package:core/exports/exports.dart';

import '../../weather.dart';

class RemotelyFetchCurrentWeather implements FetchCurrentWeather {
  RemotelyFetchCurrentWeather({required this.client, required this.storage});

  final HttpClient client;
  final Write storage;

  Future<WeatherForecast> call(WeatherFetchingInput params) async {
    final result = await client.request(
      url: ApiHelper.makeUrl(
        path: WeatherConstants.currentWeatherPath,
        queries: ApiHelper.makeForecastQuery(
          lat: params.latitude.toString(),
          lon: params.longitude.toString(),
          locale: params.locale,
        ),
      ),
    );
    final json = jsonDecode(result) as Map<String, dynamic>;
    storage.write(key: params.cacheKey, value: jsonEncode(json));
    return WeatherForecastMapper.fromJson(json).asEntity;
  }
}
