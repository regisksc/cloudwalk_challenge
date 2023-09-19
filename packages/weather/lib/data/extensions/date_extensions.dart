import 'package:intl/intl.dart';

extension DateFormatter on DateTime {
  String formatted([String? locale = 'en_US']) {
    final dateFormat = DateFormat('E, MMM d, y', locale);
    final timeFormat = DateFormat('jm', locale);

    final datePart = dateFormat.format(this);
    final timePart = timeFormat.format(this).replaceAll('\u202F', ' ');

    return '$datePart - $timePart';
  }
}
