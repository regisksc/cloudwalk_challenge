import 'package:core/core.dart';

enum WindSpeedDanger {
  low,
  moderate,
  high,
}

class WindSpeed extends Equatable {
  WindSpeed({required this.value}) {
    danger = switch (value * 2.23694) {
      >= 44.7 => WindSpeedDanger.high,
      >= 22.4 => WindSpeedDanger.moderate,
      _ => WindSpeedDanger.low,
    };
  }

  final num value;
  late final WindSpeedDanger danger;
  @override
  List<Object?> get props => [value];
}
