import '../data.dart';

abstract class HttpClient {
  Future request({
    required String url,
    required HttpMethod method,
    Map? body,
    Map? headers,
    Map? queries,
  });
}
