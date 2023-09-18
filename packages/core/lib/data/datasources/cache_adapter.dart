import 'package:flutter/services.dart';

import '../../core.dart';

class CacheAdapter implements Storage {
  CacheAdapter(this.box);

  final FlutterSecureStorage box;

  @override
  Future<String> read({required String key}) async {
    final possibleFailure = ReadingFailure(key: 'key');
    try {
      final value = await box.read(key: key);
      if (value != null) return value;
      throw possibleFailure;
    } on PlatformException {
      throw possibleFailure;
    }
  }

  @override
  Future<void> write({required String key, required String value}) async {
    final possibleFailure = WritingFailure(key: 'key');
    try {
      return box.write(key: key, value: value);
    } on PlatformException {
      throw possibleFailure;
    }
  }
}
