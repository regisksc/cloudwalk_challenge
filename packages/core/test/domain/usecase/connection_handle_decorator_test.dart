import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockConnectivity extends Mock implements Connectivity {}

class MockUsecase<Output, Input> extends Mock implements Usecase<Output, Input> {}

void main() {
  late ConnectionHandleDecorator<String, String> decorator;
  late MockUsecase<String, String> cacheDecoratee;
  late MockUsecase<String, String> remoteDecoratee;
  late MockConnectivity connectivity;

  setUp(() {
    cacheDecoratee = MockUsecase<String, String>();
    remoteDecoratee = MockUsecase<String, String>();
    connectivity = MockConnectivity();

    decorator = ConnectionHandleDecorator(
      cacheDecoratee: cacheDecoratee,
      remoteDecoratee: remoteDecoratee,
      connectivity: connectivity,
    );
  });

  test('Call should return result from remoteDecoratee when no error occurs', () async {
    // Arrange
    const params = 'testParams';
    const expectedResult = 'remoteResult';

    when(() => remoteDecoratee(params)).thenAnswer((_) async => expectedResult);

    // Act
    final result = await decorator(params);

    // Assert
    expect(result, expectedResult);
    verify(() => remoteDecoratee(params)).called(1);
    verifyNever(() => cacheDecoratee(params));
    verifyNever(() => connectivity.checkConnectivity());
  });

  test('Call should return result from cacheDecoratee when there is a connectivity error', () async {
    // Arrange
    const params = 'testParams';

    when(() => remoteDecoratee(params)).thenThrow(const SocketException('No internet'));
    when(() => connectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.none);
    const cacheResult = 'cacheResult';
    when(() => cacheDecoratee(params)).thenAnswer((_) async => cacheResult);

    // Act
    final result = await decorator(params);

    // Assert
    expect(result, cacheResult);
    verify(() => remoteDecoratee(params)).called(1);
    verify(() => cacheDecoratee(params)).called(1);
    verify(() => connectivity.checkConnectivity()).called(1);
  });

  test('Call should rethrow other exceptions', () async {
    // Arrange
    const params = 'testParams';
    final unexpectedError = Exception('Unexpected error');

    when(() => remoteDecoratee(params)).thenThrow(unexpectedError);

    // Act & Assert
    expect(() => decorator(params), throwsA(unexpectedError));
    verify(() => remoteDecoratee(params)).called(1);
    verifyNever(() => cacheDecoratee(params));
    verifyNever(() => connectivity.checkConnectivity());
  });
}
