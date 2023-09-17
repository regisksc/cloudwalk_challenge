import 'dart:convert';

import 'package:core/exports/exports.dart';

import '../../weather.dart';

class FetchWeatherForecastUsecase implements FetchWeatherForecast {
  FetchWeatherForecastUsecase(this.client);

  final HttpClient client;
  Future<List<WeatherForecast>> call(WeatherForcastInput params) async {
    final location = params;
    try {
      final result = await client.request(
        url: ApiHelper.makeUrl(
          path: ApiHelper.forecastPath,
          queries: ApiHelper.makeForecastQuery(
            lat: location.latitude.toString(),
            lon: location.longitude.toString(),
          ),
        ),
      );
      final json = jsonDecode(result) as Map<String, dynamic>;
      final listData = json['list'] as List<dynamic>;
      final mapperList = listData.map((e) => WeatherForecastMapper.fromJson(e)).toList();
      return mapperList.asEntities;
    } catch (error) {
      if (error is BadRequestFailure || error is UnauthorizedFailure) {
        throw ClientFailure();
      }
      rethrow;
    }
  }
}

extension on WeatherForecastMapper {
  WeatherForecast get asEntity {
    return WeatherForecast(
      time: time,
      tempMin: tempMin,
      tempMax: tempMax,
      weatherDescription: weatherDescription,
      windSpeed: windSpeed,
    );
  }
}

extension on List<WeatherForecastMapper> {
  List<WeatherForecast> get asEntities => map((e) => e.asEntity).toList();
}
