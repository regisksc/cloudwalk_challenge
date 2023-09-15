import 'package:cities/cities.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Geolocation', () {
    test('Valid latitude and longitude', () {
      expect(
        () => Geolocation(latitude: '12.34', longitude: '56.78'),
        returnsNormally,
      );
    });

    test('Invalid latitude', () {
      expect(
        () => Geolocation(latitude: '100.0', longitude: '56.78'),
        throwsA(isA<ArgumentError>().having((e) => e.message, 'message', 'Invalid latitude')),
      );
    });

    test('Invalid longitude', () {
      expect(
        () => Geolocation(latitude: '12.34', longitude: '200.0'),
        throwsA(isA<ArgumentError>().having((e) => e.message, 'message', 'Invalid longitude')),
      );
    });
  });
}
