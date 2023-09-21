import 'package:cities/cities.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';

void main() {
  group('Geolocation', () {
    test('Valid Geolocation', () {
      expect(
        () => Geolocation(
          name: 'Test Location',
          lat: 45.0, // Valid latitude
          lon: -75.0, // Valid longitude
          localName: 'Local Name',
          country: 'Test Country',
          state: 'Test State', modifiedWhen: faker.date.dateTime().toUtc(),
        ),
        returnsNormally,
      );
    });

    test('Invalid Latitude', () {
      expect(
        () => Geolocation(
          name: 'Test Location',
          lat: 91.0, // Invalid latitude
          lon: -75.0, // Valid longitude
          localName: 'Local Name',
          country: 'Test Country',
          state: 'Test State', modifiedWhen: faker.date.dateTime().toUtc(),
        ),
        throwsA(isA<ArgumentError>().having((e) => e.message, 'message', 'Invalid latitude')),
      );
    });

    test('Invalid Longitude', () {
      expect(
        () => Geolocation(
          name: 'Test Location',
          lat: 45.0, // Valid latitude
          lon: -181.0, // Invalid longitude
          localName: 'Local Name',
          country: 'Test Country',
          state: 'Test State', modifiedWhen: faker.date.dateTime().toUtc(),
        ),
        throwsA(isA<ArgumentError>().having((e) => e.message, 'message', 'Invalid longitude')),
      );
    });

    test('Props List', () {
      final geolocation = Geolocation(
        name: 'Test Location',
        lat: 45.0, // Valid latitude
        lon: -75.0, // Valid longitude
        localName: 'Local Name',
        country: 'Test Country',
        state: 'Test State', modifiedWhen: faker.date.dateTime().toUtc(),
      );

      expect(geolocation.props,
          [geolocation.name, geolocation.lat, geolocation.lon, geolocation.country, geolocation.state]);
    });
  });
}
