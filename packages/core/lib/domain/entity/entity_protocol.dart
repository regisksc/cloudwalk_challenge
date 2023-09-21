import '../../core.dart';

abstract class Entity extends Equatable with LastModifiedMixin {
  Entity(DateTime whenModified) {
    markAsModified(whenModified);
  }
}
