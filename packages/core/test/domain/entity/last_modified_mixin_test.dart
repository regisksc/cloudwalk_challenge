import 'package:core/core.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LastModifiedMixin', () {
    late LastModifiedMixinUsingClass testInstance;
    late DateTime dateTime;

    setUp(() {
      testInstance = LastModifiedMixinUsingClass();
      dateTime = faker.date.dateTime().toUtc();
    });

    test('markAsModified updates lastModified', () {
      final initialTime = testInstance.lastModified;
      testInstance.markAsModified(dateTime);
      final modifiedTime = testInstance.lastModified;

      expect(initialTime, isNull);
      expect(modifiedTime, isNotNull);
      expect(modifiedTime, equals(dateTime));
    });

    test('timeSinceLastModified returns "Just now" for no modification', () {
      final timeSinceModified = testInstance.timeSinceLastModified();

      expect(timeSinceModified, 'Just now');
    });

    test('timeSinceLastModified returns correct time string in minutes after modification', () {
      testInstance.markAsModified(dateTime);
      final modifiedTime = DateTime.now().toUtc().subtract(Duration(minutes: randomNumber(min: 0, max: 60).toInt()));

      testInstance.lastModified = modifiedTime;

      final timeSinceModified = testInstance.timeSinceLastModified();

      expect(timeSinceModified, contains('minute'));
    });

    test('timeSinceLastModified returns correct time string in hours after modification', () {
      testInstance.markAsModified(dateTime);
      final modifiedTime = DateTime.now().toUtc().subtract(Duration(minutes: randomNumber(min: 60, max: 120).toInt()));

      testInstance.lastModified = modifiedTime;

      final timeSinceModified = testInstance.timeSinceLastModified();

      expect(timeSinceModified, contains('hour'));
    });

    test('timeSinceLastModified returns correct time string in days after modification', () {
      testInstance.markAsModified(dateTime);
      final modifiedTime =
          DateTime.now().toUtc().subtract(Duration(minutes: randomNumber(min: 1440, max: 1600).toInt()));

      testInstance.lastModified = modifiedTime;

      final timeSinceModified = testInstance.timeSinceLastModified();

      expect(timeSinceModified, contains('day'));
    });
  });
}

class LastModifiedMixinUsingClass with LastModifiedMixin {}
