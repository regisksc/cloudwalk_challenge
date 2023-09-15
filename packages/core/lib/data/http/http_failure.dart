class HttpFailure implements Exception {}

class InvalidHttpMethod extends HttpFailure {}

class BadRequestFailure extends HttpFailure {}

class UnauthorizedFailure extends HttpFailure {}

class NotFoundFailure extends HttpFailure {}

class ServerFailure extends HttpFailure {}
