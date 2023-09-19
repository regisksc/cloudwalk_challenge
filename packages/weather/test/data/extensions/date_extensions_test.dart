import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weather/weather.dart';

void main() {
  test("should format DateTime correctly", () {
    // Create a DateTime instance for testing
    final dateTime = DateTime(2023, 9, 16, 15); // September 16, 2023, 3:00 PM
    final formatted = dateTime.formatted();
    const expected = 'Sat, Sep 16, 2023 - 3:00 PM';

    // Expect that the formatted result matches the expected string
    expect(formatted, equals(expected));
  });

  test("should format DateTime correctly with a given locale", () {
    // Create a DateTime instance for testing
    const nonDefaultLocale = 'ja_JP';
    initializeDateFormatting(nonDefaultLocale);
    final dateTime = DateTime(2023, 9, 16, 15); // September 16, 2023, 3:00 PM
    final formatted = dateTime.formatted(nonDefaultLocale);
    const expected = '土, 9月 16, 2023 - 15:00'; // formatted to japanese

    // Expect that the formatted result matches the expected string
    expect(formatted, equals(expected));
  });
}
