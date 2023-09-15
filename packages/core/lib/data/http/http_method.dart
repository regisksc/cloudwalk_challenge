enum HttpMethod { get, post }

extension HttpMethodExtension on HttpMethod {
  String get value {
    return switch (this) {
      HttpMethod.get => 'GET',
      HttpMethod.post => 'POST',
    };
  }
}
