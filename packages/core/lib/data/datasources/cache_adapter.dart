import 'package:flutter/services.dart';

import '../../core.dart';

class CacheAdapter implements Storage {
  CacheAdapter(this.box);

  final FlutterSecureStorage box;

  @override
  Future<String> read({required String key}) async {
    try {
      final value = await box.read(key: key);
      if (value != null) return value;
      throw ReadingFailure(key: key);
    } on PlatformException {
      throw ReadingFailure(key: key);
    }
  }

  @override
  Future<void> write({required String key, required String value}) async {
    try {
      return box.write(key: key, value: value);
    } on PlatformException {
      throw WritingFailure(key: key);
    }
  }
}
