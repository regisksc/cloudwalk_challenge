import 'package:core/core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late CacheAdapter cacheAdapter;
  late MockFlutterSecureStorage mockStorage;

  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    cacheAdapter = CacheAdapter(mockStorage);
  });

  test('read method returns value from FlutterSecureStorage', () async {
    // Arrange
    const key = 'testKey';
    const expectedValue = 'testValue';
    when(() => mockStorage.read(key: key)).thenAnswer((_) async => expectedValue);

    // Act
    final result = await cacheAdapter.read(key: key);

    // Assert
    expect(result, equals(expectedValue));
  });

  test('read method throws ReadingFailure when key is not found', () async {
    // Arrange
    const key = 'nonExistentKey';
    when(() => mockStorage.read(key: key)).thenThrow(PlatformException(code: 'Not found'));

    // Act and Assert
    expect(() => cacheAdapter.read(key: key), throwsA(isA<ReadingFailure>()));
  });

  test('write method stores value in FlutterSecureStorage', () async {
    // Arrange
    const key = 'testKey';
    const value = 'testValue';
    when(() => mockStorage.write(key: key, value: value)).thenAnswer((_) async => value);

    // Act
    await cacheAdapter.write(key: key, value: value);

    // Assert
    verify(() => mockStorage.write(key: key, value: value)).called(1);
  });

  test('write method throws WritingFailure on failure', () async {
    // Arrange
    const key = 'testKey';
    const value = 'testValue';
    when(() => mockStorage.write(key: key, value: value)).thenThrow(PlatformException(code: 'Write error'));

    // Act and Assert
    expect(() => cacheAdapter.write(key: key, value: value), throwsA(isA<WritingFailure>()));
  });
}
