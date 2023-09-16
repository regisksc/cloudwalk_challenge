import '../../core.dart';

abstract class Entity extends Equatable with LastModifiedMixin {
  Entity() {
    markAsModified();
  }
}
