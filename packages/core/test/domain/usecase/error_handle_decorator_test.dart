import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class UsecaseDummy implements Usecase<String, String> {
  @override
  Future<String> call(String params) async {
    throw Exception();
  }
}

class UsecaseMock extends Mock implements Usecase<String, String> {}

void main() {
  group('ErrorHandleDecorator', () {
    late UsecaseMock decoratee;
    setUp(() {
      decoratee = UsecaseMock(); // Replace with your use case and types
    });

    test('Calls _decoratee and returns its result', () async {
      // Arrange
      final decorator = ErrorHandleDecorator(decoratee);
      when(() => decoratee(any())).thenAnswer((_) async => 'Success');

      // Act
      final result = await decorator('');

      // Assert
      expect(result, 'Success');
      verify(() => decoratee(any())).called(1);
    });

    test('Handles BadRequestFailure and throws ClientFailure', () async {
      // Arrange
      final decorator = ErrorHandleDecorator(decoratee);
      when(() => decoratee(any())).thenThrow(BadRequestFailure());

      // Act and Assert
      expect(() async => decorator(''), throwsA(isA<ClientFailure>()));
      verify(() => decoratee(any())).called(1);
    });

    test('Handles UnauthorizedFailure and throws ClientFailure', () async {
      // Arrange
      final decorator = ErrorHandleDecorator(decoratee);
      when(() => decoratee(any())).thenThrow(UnauthorizedFailure());

      // Act and Assert
      expect(() async => decorator(''), throwsA(isA<ClientFailure>()));
      verify(() => decoratee(any())).called(1);
    });

    test('Rethrows other errors', () async {
      // Arrange
      final decorator = ErrorHandleDecorator(decoratee);
      when(() => decoratee(any())).thenThrow(Exception('Generic Error'));

      // Act and Assert
      expect(() async => decorator(''), throwsA(isA<Exception>()));
      verify(() => decoratee(any())).called(1);
    });
  });
}
