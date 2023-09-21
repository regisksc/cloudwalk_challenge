import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

import '../data.dart';

class HttpDatasource implements HttpClient {
  HttpDatasource({
    required this.client,
    required this.baseUrl,
  });

  final Client client;
  final String baseUrl;

  @override
  Future request({
    required String url,
    HttpMethod method = HttpMethod.get,
    Map? body,
    Map? headers,
    Map? queries,
  }) async {
    final jsonBody = body != null ? jsonEncode(body) : null;
    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll({'content-type': 'application/json', 'accept': 'application/json'});
    var response = Response('', 500);
    Future<Response>? futureResponse;
    try {
      futureResponse = switch (method.value) {
        'GET' => client.get(Uri.parse(url), headers: defaultHeaders),
        'POST' => client.post(Uri.parse(url), headers: defaultHeaders, body: jsonBody),
        String() => null,
      };
      if (futureResponse != null) response = await futureResponse.timeout(const Duration(seconds: 10));
    } catch (error) {
      if (error is TimeoutException || error is SocketException) rethrow;
      throw ServerFailure();
    }
    return _handleResponse(response);
  }

  dynamic _handleResponse(Response response) {
    if (response.body == "[]") throw NotFoundFailure();
    return switch (response.statusCode) {
      200 => jsonDecode(response.body),
      204 => null,
      400 => throw BadRequestFailure(),
      401 || 403 => throw UnauthorizedFailure(),
      404 => throw NotFoundFailure(),
      _ => throw ServerFailure(),
    };
  }
}
