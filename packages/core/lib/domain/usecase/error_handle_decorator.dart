import '../../core.dart';

class ErrorHandleDecorator<Output, Input> extends Usecase<Output, Input> {
  ErrorHandleDecorator(this._decoratee);

  final Usecase<Output, Input> _decoratee;
  @override
  Future<Output> call(Input params) async {
    try {
      return await _decoratee(params);
    } catch (error) {
      if (error is BadRequestFailure || error is UnauthorizedFailure) {
        throw ClientFailure();
      }
      rethrow;
    }
  }
}
