import 'package:flutter/foundation.dart';

abstract class StorageFailure {
  StorageFailure({required this.message}) {
    debugPrint(message);
  }

  final String message;
}

class ReadingFailure extends StorageFailure {
  ReadingFailure({required String key}) : super(message: 'Storage: No value was found for key $key');
}

class WritingFailure extends StorageFailure {
  WritingFailure({required String key}) : super(message: 'Storage: Could not save value for key $key');
}
