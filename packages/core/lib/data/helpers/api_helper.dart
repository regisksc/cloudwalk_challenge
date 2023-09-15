abstract class ApiHelper {
  ApiHelper._();

  static String get geolocationPath => '/geo/1.0/direct';
  static String get forecastPath => '/data/2.5/forecast';
  static Map<String, dynamic> get _apiKey => {"appid": "586fe855ce36758b2c7e6256cda20241"};
  static Map<String, dynamic> makeGeolocationQuery(String query) => {"q": query};
  static Map<String, dynamic> makeForecastQuery({required String lat, required String lon}) {
    return {"lat": lat, "lon": lon};
  }

  static String makeUrl({required String path, required Map<String, dynamic> queries}) {
    const baseUrl = "api.openweathermap.org";
    final uri = Uri(
      scheme: "http",
      host: baseUrl,
      path: path,
      queryParameters: Map<String, dynamic>.from(queries)..addAll(_apiKey),
    );

    return uri.toString();
  }
}
