import 'package:cities/cities.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';

void main() {
  final faker = Faker();

  group('City', () {
    test('should create a valid City instance', () {
      // Arrange: Create a City instance with a valid name
      final cityName = faker.address.city();
      final city = City(name: cityName);

      // Assert: Check if the instance was created successfully
      expect(city, isA<City>());
    });

    test('copyWith should create a new City with updated values', () {
      // Arrange: Create an initial City object
      final cityName = faker.address.city();
      final initialCity = City(name: cityName);

      // Act: Use copyWith to create a new City object with updated values
      final updatedCity = initialCity.copyWith(name: faker.address.city());

      // Assert: Check if the updated City object has the expected values
      expect(updatedCity.name, isNotNull);
    });

    test('copyWith should return the same object if no updates are provided', () {
      // Arrange: Create an initial City object
      final cityName = faker.address.city();
      final initialCity = City(name: cityName);

      // Act: Use copyWith without providing any updates
      final sameCity = initialCity.copyWith();

      // Assert: Check if the same object reference is returned
      expect(sameCity, same(initialCity));
    });

    test('timeSinceLastModified returns a valid time string', () {
      // Arrange: Create a City object and mark it as modified
      final cityName = faker.address.city();
      final city = City(name: cityName);
      city.markAsModified();

      // Act: Get the time since last modification
      final timeSinceModified = city.timeSinceLastModified();

      // Assert: Check if the time string is not empty
      expect(timeSinceModified, isNotEmpty);
    });
  });
}
