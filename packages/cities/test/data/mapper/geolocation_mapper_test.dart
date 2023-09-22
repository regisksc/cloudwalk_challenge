import 'package:cities/cities.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';

import '../../_utils/mocks.dart';

void main() {
  final faker = Faker();

  test('fromJson should correctly parse a JSON map', () {
    final json = {
      'name': faker.address.city(),
      'lat': faker.geo.latitude(),
      'lon': faker.geo.longitude(),
      'country': faker.address.country(),
      'state': faker.address.state(),
      'dt': DateTime.now().toUtc().millisecondsSinceEpoch,
    };

    final geolocation = GeolocationMapper.fromJson(json);

    expect(geolocation, isA<GeolocationMapper>());
    expect(geolocation.name, json['name']);
    expect(geolocation.lat, json['lat']);
    expect(geolocation.lon, json['lon']);
    expect(geolocation.country, json['country']);
    expect(geolocation.state, json['state']);
  });

  test('toJson should correctly serialize to a JSON map', () {
    final geolocation = GeolocationMapper(
      name: faker.address.city(),
      lat: faker.geo.latitude(),
      lon: faker.geo.longitude(),
      country: faker.address.country(),
      state: faker.address.state(),
    );

    final json = geolocation.toJson();

    expect(json, isA<Map<String, dynamic>>());
    expect(json['name'], geolocation.name);
    expect(json['lat'], geolocation.lat);
    expect(json['lon'], geolocation.lon);
    expect(json['country'], geolocation.country);
    expect(json['state'], geolocation.state);
  });

  test('GeolocationMapperExtension asEntity should return a Geolocation object', () {
    final geolocation = geolocationMapper.asEntity;

    expect(geolocation.name, geolocationMapper.name);
    expect(geolocation.lat, geolocationMapper.lat);
    expect(geolocation.lon, geolocationMapper.lon);
    expect(geolocation.localName, geolocationMapper.localName);
    expect(geolocation.country, geolocationMapper.country);
    expect(geolocation.state, geolocationMapper.state);
  });
}
