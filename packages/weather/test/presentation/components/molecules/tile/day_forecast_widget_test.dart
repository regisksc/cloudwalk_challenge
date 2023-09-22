import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather/weather.dart';

import '../../../../_utils/mocks.dart';

void main() {
  testWidgets('DayForecastWidget displays forecast data', (WidgetTester tester) async {
    final forecast = weatherForecastMock;

    await tester.pumpWidget(
      MaterialApp(home: DayForecastWidget(forecast)),
    );

    expect(find.byType(DateContainer), findsOneWidget);
    expect(find.byType(WeatherConditionsContainer), findsOneWidget);

    await expectLater(
      find.byType(DayForecastWidget),
      matchesGoldenFile('day_forecast_widget.png'),
    );
  });
}
