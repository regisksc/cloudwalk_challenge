import 'dart:convert';

import 'package:cities/cities.dart';
import 'package:core/core.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../_fixtures/json_fixture_reader.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late MockHttpClient client;

  setUp(() {
    client = MockHttpClient();
  });

  setUpAll(() {
    registerFallbackValue(HttpMethod.get);
  });

  test('Successful Geolocation', () async {
    final remotelyGeolocateCity = RemotelyGeolocateCity(client);
    const params = GeolocationInput(cityName: 'Test City', locale: 'en');
    final jsonString = fixture('sao_paulo_geolocation_result_fixture.json');
    final jsonList = jsonDecode(jsonString) as List;

    // Arrange:
    when(
      () => client.request(url: any(named: 'url'), method: any(named: 'method')),
    ).thenAnswer((_) async => jsonEncode(jsonList));

    // Act
    final geolocations = await remotelyGeolocateCity.call(params);

    // Assert
    verify(() => client.request(url: any(named: 'url'), method: any(named: 'method')));
    expect(geolocations, isA<List<Geolocation>>());
    expect(geolocations.length, jsonList.length);
  });
}
