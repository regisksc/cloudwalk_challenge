class HttpFailure implements Exception {}

class BadRequestFailure extends HttpFailure {}

class UnauthorizedFailure extends HttpFailure {}

class NotFoundFailure extends HttpFailure {}

class ServerFailure extends HttpFailure {}

class ClientFailure extends HttpFailure {}
