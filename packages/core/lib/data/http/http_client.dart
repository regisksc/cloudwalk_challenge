import '../data.dart';

abstract class HttpClient {
  Future request({
    required String url,
    HttpMethod method = HttpMethod.get,
    Map? body,
    Map? headers,
    Map? queries,
  });
}
