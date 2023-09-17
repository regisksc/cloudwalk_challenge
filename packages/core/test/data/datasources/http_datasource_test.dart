import 'dart:convert';
import 'package:core/data/data.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements Client {}

void main() {
  late HttpDatasource httpDatasource;
  late MockClient mockClient;
  final urlFake = faker.internet.httpsUrl();

  setUp(() {
    mockClient = MockClient();
    httpDatasource = HttpDatasource(client: mockClient, baseUrl: urlFake);
  });

  setUpAll(() {
    registerFallbackValue(Uri.parse(urlFake));
  });

  test('request should make a GET request successfully', () async {
    final expectedResponse = {'key': faker.lorem.sentence()};
    when(() => mockClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => Response(jsonEncode(expectedResponse), 200));

    final response = await httpDatasource.request(url: 'test');

    expect(response, equals(expectedResponse));
  });

  test('request should make a POST request successfully', () async {
    final requestBody = {'key': faker.lorem.sentence()};
    final expectedResponse = {'key': faker.lorem.sentence()};
    when(() => mockClient.post(any(), headers: any(named: 'headers'), body: any(named: 'body')))
        .thenAnswer((_) async => Response(jsonEncode(expectedResponse), 200));

    final response = await httpDatasource.request(
      url: 'test',
      method: HttpMethod.post,
      body: requestBody,
    );

    expect(response, equals(expectedResponse));
  });
}
