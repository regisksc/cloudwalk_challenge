import 'package:cities/cities.dart';
import 'package:core/core.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class RemotelyGeolocateCity implements GeolocateCity {
  RemotelyGeolocateCity(this.client);

  final HttpClient client;

  @override
  Future<City> call(City params) async {
    final city = params;
    final geolocationJson = await client.request(
      url: ApiHelper.makeUrl(
        path: ApiHelper.geolocationPath,
        queries: ApiHelper.makeGeolocationQuery(city.name),
      ),
      method: HttpMethod.get,
    ) as List<Map<String, dynamic>>;

    final latitude = geolocationJson.first['lat'];
    final longitude = geolocationJson.first['lon'];
    final geolocation = Geolocation(latitude: latitude, longitude: longitude);

    return city.copyWith(geolocation: geolocation);
  }
}

class MockClient extends Mock implements HttpDatasource {}

void main() {
  late HttpClient client;
  late RemotelyGeolocateCity sut;

  final geolocationJson = [
    {
      'name': 'Uberaba',
      'lat': -19.350876900000003,
      'lon': -48.24289795348889,
      'country': 'BR',
      'state': 'Minas Gerais',
    },
  ];

  setUp(() {
    client = MockClient();
    sut = RemotelyGeolocateCity(client);
  });

  setUpAll(() {
    registerFallbackValue(HttpMethod.post);
  });

  group('should geolocate a city with coordinates and...', () {
    late String cityName;
    late City inputCity;
    late City result;
    final expectedLatitude = geolocationJson.first['lat'];
    final expectedLongitude = geolocationJson.first['lon'];

    setUp(() async {
      // Arrange: Create an instance of GeolocateCityFromRemote
      cityName = faker.address.city();
      inputCity = City(name: cityName);
      when(
        () => client.request(
          url: any(named: 'url'),
          method: any(named: 'method'),
        ),
      ).thenAnswer((_) async => geolocationJson);
      // Act: Call the use case with the input city
      result = await sut(inputCity);
    });

    test('is a City entity', () async => expect(result, isA<City>()));
    test('has a Geolocation entity stored', () async => expect(result.geolocation, isA<Geolocation>()));
    test('its Geolocation has a latitude', () async => expect(result.geolocation?.latitude, isNotNull));
    test('latitude is as expected', () async => expect(result.geolocation?.latitude, expectedLatitude));
    test('its Geolocation has a longitude', () async => expect(result.geolocation?.longitude, isNotNull));
    test('longitude is as expected', () async => expect(result.geolocation?.longitude, expectedLongitude));
  });
}
