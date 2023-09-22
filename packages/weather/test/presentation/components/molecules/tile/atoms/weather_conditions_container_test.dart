import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather/weather.dart';

import '../../../../../_utils/mocks.dart';

void main() {
  testWidgets('Test WeatherConditionsContainer Widget', (WidgetTester tester) async {
    final weatherForecast = weatherForecastMock;

    await tester.pumpWidget(MaterialApp(
      home: MediaQuery(
        data: const MediaQueryData(size: Size(800, 651)), // Larger screen size
        child: WeatherConditionsContainer(weatherForecast),
      ),
    ));

    expect(find.byKey(const ValueKey('_LargerScreenLayout')), findsOneWidget);
    expect(find.byKey(const ValueKey('_ShorterScreenLayout')), findsNothing);

    await tester.pumpWidget(MaterialApp(
      home: MediaQuery(
        data: const MediaQueryData(size: Size(400, 800)), // Smaller screen size
        child: WeatherConditionsContainer(weatherForecast),
      ),
    ));

    expect(find.byKey(const ValueKey('_ShorterScreenLayout')), findsOneWidget);
    expect(find.byKey(const ValueKey('_LargerScreenLayout')), findsNothing);

    await expectLater(
      find.byType(WeatherConditionsContainer),
      matchesGoldenFile('weather_conditions_container.png'),
    );
  });
}
