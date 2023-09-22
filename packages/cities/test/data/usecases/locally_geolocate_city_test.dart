import 'dart:convert';

import 'package:cities/cities.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../_utils/mocks.dart';

class MockRead extends Mock implements Read {}

void main() {
  group('LocallyGeolocateCity', () {
    late LocallyGeolocateCity geolocator;
    late MockRead mockStorage;

    setUp(() {
      mockStorage = MockRead();
      geolocator = LocallyGeolocateCity(storage: mockStorage);
    });

    test('should return a list of Geolocation', () async {
      // Arrange
      final cachedResult = [geolocationMapper.toJson()];

      when(() => mockStorage.read(key: geolocationInputMock.cacheKey)).thenAnswer(
        (_) async => jsonEncode(cachedResult),
      );

      // Act
      final result = await geolocator.call(geolocationInputMock);

      // Assert
      expect(result, isA<List<Geolocation>>());
      expect(result.length, 1);
    });

    test('should return an empty list if cache is empty', () async {
      // Arrange
      when(() => mockStorage.read(key: any(named: 'key'))).thenThrow(
        ReadingFailure(key: geolocationInputMock.cacheKey),
      );

      // Act and Assert
      expect(() => geolocator.call(geolocationInputMock), throwsA(isA<ReadingFailure>()));
    });
  });
}
