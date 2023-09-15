import 'package:core/data/data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('HttpMethodExtension should convert HttpMethod to string correctly', () {
    const getMethod = HttpMethod.get;
    const postMethod = HttpMethod.post;

    expect(getMethod.value, 'GET');
    expect(postMethod.value, 'POST');
  });
}
