import 'package:core/core.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LastModifiedMixin', () {
    late LastModifiedMixinUsingClass testInstance;

    setUp(() {
      testInstance = LastModifiedMixinUsingClass();
    });

    test('markAsModified updates lastModified', () {
      final initialTime = testInstance.lastModified;
      testInstance.markAsModified();
      final modifiedTime = testInstance.lastModified;

      expect(initialTime, isNull);
      expect(modifiedTime, isNotNull);
    });

    test('timeSinceLastModified returns "Just now" for no modification', () {
      final timeSinceModified = testInstance.timeSinceLastModified();

      expect(timeSinceModified, 'Just now');
    });

    test('timeSinceLastModified returns correct time string after modification', () {
      testInstance.markAsModified();
      final modifiedTime = DateTime.now().subtract(Duration(minutes: faker.randomGenerator.integer(120)));

      testInstance.lastModified = modifiedTime;

      final timeSinceModified = testInstance.timeSinceLastModified();

      final minutes = modifiedTime.difference(DateTime.now()).inMinutes.abs();
      expect(timeSinceModified, '$minutes ${minutes == 1 ? 'minute' : 'minutes'} ago');
    });
  });
}

class LastModifiedMixinUsingClass with LastModifiedMixin {}
