import 'package:cities/cities.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final faker = Faker();
  group('City', () {
    test('CopyWith should create a new City object with updated values', () {
      // Arrange: Create an initial City object with random data
      final initialCity = City(
        name: faker.address.city(),
        geolocation: Geolocation(
          latitude: faker.randomGenerator.decimal(scale: 3).toString(),
          longitude: faker.randomGenerator.decimal(scale: 3).toString(),
        ),
      );

      // Act: Use copyWith to create a new City object with updated values
      final updatedCity = initialCity.copyWith(
        name: faker.address.city(),
        geolocation: Geolocation(
          latitude: faker.randomGenerator.decimal(scale: 3).toString(),
          longitude: faker.randomGenerator.decimal(scale: 3).toString(),
        ),
      );

      // Assert: Check if the updated City object has the expected values
      expect(updatedCity.name, isNot(equals(initialCity.name)));
      expect(updatedCity.geolocation!.latitude, isNot(equals(initialCity.geolocation!.latitude)));
      expect(updatedCity.geolocation!.longitude, isNot(equals(initialCity.geolocation!.longitude)));
    });
  });
}
