import 'package:core/data/data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('HttpFailure should be a subclass of Exception', () {
    final failure = HttpFailure();

    expect(failure, isA<Exception>());
  });

  test('InvalidHttpMethod should be a subclass of HttpFailure', () {
    final invalidMethod = InvalidHttpMethod();

    expect(invalidMethod, isA<HttpFailure>());
  });

  test('BadRequestFailure should be a subclass of HttpFailure', () {
    final badRequest = BadRequestFailure();

    expect(badRequest, isA<HttpFailure>());
  });

  test('UnauthorizedFailure should be a subclass of HttpFailure', () {
    final unauthorized = UnauthorizedFailure();

    expect(unauthorized, isA<HttpFailure>());
  });

  test('NotFoundFailure should be a subclass of HttpFailure', () {
    final notFound = NotFoundFailure();

    expect(notFound, isA<HttpFailure>());
  });

  test('ServerFailure should be a subclass of HttpFailure', () {
    final serverError = ServerFailure();

    expect(serverError, isA<HttpFailure>());
  });
}
