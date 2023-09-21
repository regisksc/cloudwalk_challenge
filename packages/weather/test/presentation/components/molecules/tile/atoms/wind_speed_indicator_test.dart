import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather/weather.dart';

void main() {
  testWidgets('Test WindSpeedIndicator Widget', (WidgetTester tester) async {
    const windSpeedVal = 5;
    final weatherForecast = WeatherForecast(
      modifiedWhen: DateTime.now(),
      tempMax: Temperature(value: 70),
      time: ForecastTime(unixTimestamp: DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000),
      tempMin: Temperature(value: 65),
      weatherDescription: '',
      windSpeed: WindSpeed(value: windSpeedVal),
    );

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
