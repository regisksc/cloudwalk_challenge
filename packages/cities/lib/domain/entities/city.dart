import 'package:core/core.dart';

import '../domain.dart';

class City extends Entity {
  City({
    required String name,
    this.geolocation,
  }) {
    RegExp(r'^[A-Za-z\s]+$').hasMatch(name) ? _name = name : throw ArgumentError('Invalid city name: $name');
  }

  String get name => _name;
  String _name = '';
  final Geolocation? geolocation;

  @override
  List<Object?> get props => [name, geolocation];

  City copyWith({
    String? name,
    Geolocation? geolocation,
  }) {
    if (name == null && geolocation == null) return this;
    final entity = City(
      name: name ?? this.name,
      geolocation: geolocation ?? this.geolocation,
    );
    entity.markAsModified();
    return entity;
  }
}
