import 'package:core/core.dart';

import '../domain.dart';

class City extends Entity {
  City({
    required this.name,
    required this.geolocation,
  });

  final String name;
  final Geolocation? geolocation;

  @override
  List<Object?> get props => [name, geolocation];

  City copyWith({
    String? name,
    Geolocation? geolocation,
  }) {
    return City(
      name: name ?? this.name,
      geolocation: geolocation ?? this.geolocation,
    );
  }
}
