import 'package:core/core.dart';
import 'package:test/test.dart';

void main() {
  test('geolocationPath should return the correct path', () {
    const expectedPath = '/geo/1.0/direct';
    final actualPath = ApiHelper.geolocationPath;
    expect(actualPath, expectedPath);
  });

  

  test('makeGeolocationQuery should create the correct query map', () {
    final query = ApiHelper.makeGeolocationQuery('New York');
    expect(query, equals({"q": "New York"}));
  });

  test('makeForecastQuery should create the correct query map', () {
    final query = ApiHelper.makeForecastQuery(lat: '40.7128', lon: '-74.0060');
    expect(query, equals({"lat": "40.7128", "lon": "-74.0060", "lang": 'en', "units": "imperial"}));
  });

  test('makeForecastQuery should create the correct query map with locale', () {
    final query = ApiHelper.makeForecastQuery(lat: '40.7128', lon: '-74.0060', locale: 'es');
    expect(query, equals({"lat": "40.7128", "lon": "-74.0060", "lang": 'es', "units": "metric"}));
  });

  test('makeUrl should create the correct URL', () {
    const path = '/geo/1.0/direct';
    final queries = ApiHelper.makeGeolocationQuery("New York");
    final url = ApiHelper.makeUrl(path: path, queries: queries);

    // Replace with the expected URL based on your API structure
    const expectedUrl =
        "http://api.openweathermap.org/geo/1.0/direct?q=New+York&appid=586fe855ce36758b2c7e6256cda20241";

    expect(url, equals(expectedUrl));
  });
}
