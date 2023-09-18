import 'package:core/core.dart';
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

    test('timeSinceLastModified returns correct time string in minutes after modification', () {
      testInstance.markAsModified();
      final modifiedTime = DateTime.now().subtract(Duration(minutes: randomNumber(min: 0, max: 60).toInt()));

      testInstance.lastModified = modifiedTime;

      final timeSinceModified = testInstance.timeSinceLastModified();

      expect(timeSinceModified, contains('minute'));
    });

    test('timeSinceLastModified returns correct time string in hours after modification', () {
      testInstance.markAsModified();
      final modifiedTime = DateTime.now().subtract(Duration(minutes: randomNumber(min: 60, max: 120).toInt()));

      testInstance.lastModified = modifiedTime;

      final timeSinceModified = testInstance.timeSinceLastModified();

      expect(timeSinceModified, contains('hour'));
    });

    test('timeSinceLastModified returns correct time string in days after modification', () {
      testInstance.markAsModified();
      final modifiedTime = DateTime.now().subtract(Duration(minutes: randomNumber(min: 1440, max: 1600).toInt()));

      testInstance.lastModified = modifiedTime;

      final timeSinceModified = testInstance.timeSinceLastModified();

      expect(timeSinceModified, contains('day'));
    });
  });
}

class LastModifiedMixinUsingClass with LastModifiedMixin {}
