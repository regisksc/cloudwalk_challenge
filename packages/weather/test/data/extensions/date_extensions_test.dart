import 'package:flutter_test/flutter_test.dart';
import 'package:weather/weather.dart';

void main() {
  test("should format DateTime as 'MMM d, yy 'at' h'am/pm'", () {
    // Create a DateTime instance for testing
    final dateTime = DateTime(2023, 9, 16, 15); // September 16, 2023, 3:00 PM
    final formatted = dateTime.formatted;
    const expected = 'Sep 16, 23 at 3pm';

    // Expect that the formatted result matches the expected string
    expect(formatted, expected);
  });
}
