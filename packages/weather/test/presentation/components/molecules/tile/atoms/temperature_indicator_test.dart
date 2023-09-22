import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather/weather.dart';

import '../../../../../_utils/mocks.dart';

void main() {
  testWidgets('Test TemperatureIndicator Widget', (WidgetTester tester) async {
    final weatherForecast = weatherForecastMock;

    await tester.pumpWidget(MaterialApp(
      home: TemperatureIndicator(label: 'label', temperature: weatherForecast.tempMin),
    ));

    expect(find.byType(TemperatureIndicator), findsOneWidget);

    await expectLater(
      find.byType(TemperatureIndicator),
      matchesGoldenFile('temperature_indicator.png'),
    );
  });
}
