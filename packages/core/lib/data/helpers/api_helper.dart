abstract class ApiHelper {
  ApiHelper._();

  static String get geolocationPath => '/geo/1.0/direct';
  static Map<String, dynamic> get _apiKey => {"appid": "586fe855ce36758b2c7e6256cda20241"};
  static Map<String, dynamic> makeGeolocationQuery(String query) => {"q": query};
  static Map<String, dynamic> makeForecastQuery({required String lat, required String lon, String? locale = 'en'}) {
    final lang = locale ?? 'en';
    return {
      "lat": lat,
      "lon": lon,
      "lang": lang,
      "units": lang.contains('en') ? 'imperial' : 'metric',
    };
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
