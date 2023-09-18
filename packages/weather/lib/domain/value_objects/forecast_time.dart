import 'package:core/exports/exports.dart';

import '../../weather.dart';

class ForecastTime extends Equatable {
  ForecastTime({
    required int unixTimestamp,
    String? locale = 'en_US',
  }) {
    formatted = DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000).formatted(locale);
  }

  late String formatted;
  @override
  List<Object?> get props => [formatted];
}
