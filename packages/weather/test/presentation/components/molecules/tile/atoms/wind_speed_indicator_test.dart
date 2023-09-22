import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather/weather.dart';

import '../../../../../_utils/mocks.dart';

void main() {
  testWidgets('Test WindSpeedIndicator Widget', (WidgetTester tester) async {
    const windSpeedVal = 5;
    final weatherForecast = weatherForecastMock;

    await tester.pumpWidget(MaterialApp(
      home: WindSpeedIndicator(speed: weatherForecast.windSpeed),
    ));

    expect(find.text('$windSpeedVal m/s'), findsOneWidget);

    await expectLater(
      find.byType(WindSpeedIndicator),
      matchesGoldenFile('wind_speed_indicator.png'),
    );
  });
}
