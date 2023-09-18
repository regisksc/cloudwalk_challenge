abstract class Storage implements Read, Write {}

abstract class StorageOperation {}

abstract class Write extends StorageOperation {
  Future write({required String key, required String value});
}

abstract class Read extends StorageOperation {
  Future<String> read({required String key});
}
