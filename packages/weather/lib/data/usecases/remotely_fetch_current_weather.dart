import 'dart:convert';

import 'package:core/exports/exports.dart';

import '../../weather.dart';

class RemotelyFetchCurrentWeather implements FetchCurrentWeather {
  RemotelyFetchCurrentWeather(this.client);

  final HttpClient client;
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
    return WeatherForecastMapper.fromJson(json).asEntity;
  }
}
