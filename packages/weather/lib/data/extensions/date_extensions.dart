import 'package:intl/intl.dart';

extension DateFormatter on DateTime {
  String formatted([String? locale = 'en_US']) {
    final format = DateFormat('E, MMM d, yy', locale);
    return format.format(this);
  }
}
