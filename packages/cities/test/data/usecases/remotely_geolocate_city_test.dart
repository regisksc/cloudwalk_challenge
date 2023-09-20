import 'dart:convert';

import 'package:cities/cities.dart';
import 'package:core/core.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../_fixtures/json_fixture_reader.dart';

class MockHttpClient extends Mock implements HttpClient {}

class MockWrite extends Mock implements Write {}

void main() {
  late MockHttpClient client;
  late MockWrite storage;

  setUp(() {
    client = MockHttpClient();
    storage = MockWrite();
  });

  setUpAll(() {
    registerFallbackValue(HttpMethod.get);
  });

  test('Successful Geolocation', () async {
    final remotelyGeolocateCity = RemotelyGeolocateCity(client: client, storage: storage);
    const params = GeolocationInput(cityName: 'Test City', locale: 'en');
    final jsonString = fixture('sao_paulo_geolocation_result_fixture.json');
    final jsonList = jsonDecode(jsonString) as List;

    // Arrange:
    when(
      () => client.request(url: any(named: 'url'), method: any(named: 'method')),
    ).thenAnswer((_) async => jsonEncode(jsonList));
    when(
      () => storage.write(key: params.cacheKey, value: any(named: 'value')),
    ).thenAnswer((_) => Future.value());

    // Act
    final geolocations = await remotelyGeolocateCity.call(params);

    // Assert
    verify(() => client.request(url: any(named: 'url'), method: any(named: 'method')));
    expect(geolocations, isA<List<Geolocation>>());
    expect(geolocations.length, jsonList.length);
  });
}
