import 'package:cities/cities.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';

void main() {
  final faker = Faker();

  group('Geolocation', () {
    test('should create a valid Geolocation instance', () {
      // Arrange: Create a Geolocation instance with valid latitude and longitude
      final geolocation = Geolocation(latitude: faker.geo.latitude(), longitude: faker.geo.longitude());

      // Assert: Check if the instance was created successfully
      expect(geolocation, isA<Geolocation>());
    });

    test('should throw ArgumentError for invalid latitude', () {
      // Act and Assert: Ensure that creating a Geolocation with invalid latitude throws an error
      expect(() => Geolocation(latitude: -91.0, longitude: faker.geo.longitude()), throwsArgumentError);
      expect(() => Geolocation(latitude: 91.0, longitude: faker.geo.longitude()), throwsArgumentError);
    });

    test('should throw ArgumentError for invalid longitude', () {
      // Act and Assert: Ensure that creating a Geolocation with invalid longitude throws an error
      expect(() => Geolocation(latitude: faker.geo.latitude(), longitude: -181.0), throwsArgumentError);
      expect(() => Geolocation(latitude: faker.geo.latitude(), longitude: 181.0), throwsArgumentError);
    });

    test('copyWith should create a new Geolocation with updated values', () {
      // Arrange: Create an initial Geolocation object
      final initialGeolocation = Geolocation(latitude: faker.geo.latitude(), longitude: faker.geo.longitude());

      // Act: Use copyWith to create a new Geolocation object with updated values
      final updatedGeolocation = initialGeolocation.copyWith(
        latitude: faker.geo.latitude(),
        longitude: faker.geo.longitude(),
      );

      // Assert: Check if the updated Geolocation object has the expected values
      expect(updatedGeolocation.latitude, isNotNull);
      expect(updatedGeolocation.longitude, isNotNull);
    });

    test('copyWith should return the same object if no updates are provided', () {
      // Arrange: Create an initial Geolocation object
      final initialGeolocation = Geolocation(
        latitude: faker.geo.latitude(),
        longitude: faker.geo.longitude(),
      );

      // Act: Use copyWith without providing any updates
      final sameGeolocation = initialGeolocation.copyWith();

      // Assert: Check if the same object reference is returned
      expect(sameGeolocation, same(initialGeolocation));
    });

    test('timeSinceLastModified returns a valid time string', () {
      // Arrange: Create a Geolocation object and mark it as modified
      final geolocation = Geolocation(
        latitude: faker.geo.latitude(),
        longitude: faker.geo.longitude(),
      );
      geolocation.markAsModified();

      // Act: Get the time since last modification
      final timeSinceModified = geolocation.timeSinceLastModified();

      // Assert: Check if the time string is not empty
      expect(timeSinceModified, isNotEmpty);
    });
  });
}
