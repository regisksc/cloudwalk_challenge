import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather/weather.dart';

void main() {
  testWidgets('Test TemperatureIndicator Widget', (WidgetTester tester) async {
    final weatherForecast = WeatherForecast(
      modifiedWhen: DateTime.now(),
      tempMax: Temperature(value: 70),
      time: ForecastTime(unixTimestamp: DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000),
      tempMin: Temperature(value: 65),
      weatherDescription: '',
      windSpeed: WindSpeed(value: 5),
    );

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
