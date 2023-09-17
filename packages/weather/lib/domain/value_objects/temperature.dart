import 'package:core/exports/exports.dart';

enum TemperatureDanger {
  unbearablyCold,
  cold,
  warm,
  hot,
  unbearablyHot,
}

class Temperature extends Equatable {
  Temperature({required this.value}) {
    danger = switch (value) {
      < 32 => TemperatureDanger.unbearablyCold,
      < 59 && > 32 => TemperatureDanger.cold,
      < 77 && > 59 => TemperatureDanger.warm,
      < 95 && > 77 => TemperatureDanger.hot,
      _ => TemperatureDanger.unbearablyHot,
    };
  }

  final num value;
  late TemperatureDanger danger;

  @override
  List<Object?> get props => [value];
}
