import 'package:intl/intl.dart';

extension DateFormatter on DateTime {
  String get formatted {
    final format = DateFormat("MMM d, yy 'at' h'${hour < 12 ? 'am' : 'pm'}'", 'en_US');
    return format.format(this);
  }
}
