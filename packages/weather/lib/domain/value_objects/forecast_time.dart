import 'package:core/exports/exports.dart';

import '../../weather.dart';

class ForecastTime extends Equatable {
  ForecastTime({
    required int unixTimestamp,
    String? locale = 'en_US',
  }) {
    _date = DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);
    formatted = _date.formatted(locale);
  }

  late DateTime _date;
  late String formatted;

  int get toUnix => _date.toUtc().millisecondsSinceEpoch ~/ 1000;
  @override
  List<Object?> get props => [formatted];
}
