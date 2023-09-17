import 'package:cities/cities.dart';
import 'package:core/core.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockClient extends Mock implements HttpDatasource {}

void main() {
  late HttpClient client;
  late RemotelyGeolocateCity sut;

  late String cityName;
  late City inputCity;

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
    cityName = faker.address.city();
    inputCity = City(name: cityName);

    client = MockClient();
    sut = RemotelyGeolocateCity(client);
  });

  setUpAll(() {
    registerFallbackValue(HttpMethod.post);
  });

  group('should geolocate a city with coordinates and...', () {
    late City result;
    final expectedLatitude = geolocationJson.first['lat'];
    final expectedLongitude = geolocationJson.first['lon'];

    setUp(() async {
      // Arrange: SetUp request
      when(
        () => client.request(url: any(named: 'url')),
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

  group('should handle errors on failures and ...', () {
    test('throw a ServerFailure when lat and lon return as empty', () async {
      when(
        () => client.request(url: any(named: 'url')),
      ).thenAnswer((_) async {
        final json = geolocationJson.first;
        json['lat'] = '';
        json['lon'] = '';
        return [json];
      });
      expect(() => sut(inputCity), throwsA(isA<ServerFailure>()));
    });

    group('', () {
      void catchRequestFailure(HttpFailure failure) {
        when(
          () => client.request(url: any(named: 'url')),
        ).thenThrow(failure);
      }

      test('throw a ClientFailure on getting BadRequestFailure', () {
        // Arrange: mock an HttpFailure
        catchRequestFailure(BadRequestFailure());
        expect(() => sut(inputCity), throwsA(isA<ClientFailure>()));
      });
      test('throw a ClientFailure on getting UnauthorizedFailure', () {
        // Arrange: mock an HttpFailure
        catchRequestFailure(UnauthorizedFailure());
        expect(() => sut(inputCity), throwsA(isA<ClientFailure>()));
      });
      test('throw a ClientFailure on getting NotFoundFailure', () {
        // Arrange: mock an HttpFailure
        catchRequestFailure(NotFoundFailure());
        expect(() => sut(inputCity), throwsA(isA<ClientFailure>()));
      });
    });
  });
}
