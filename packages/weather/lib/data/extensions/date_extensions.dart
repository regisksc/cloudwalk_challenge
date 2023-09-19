import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

extension DateFormatter on DateTime {
  String formatted([String? locale = 'en_US']) {
    initializeDateFormatting(locale);
    final format = DateFormat('E, MMM d, yy', locale);
    return format.format(this);
  }
}
