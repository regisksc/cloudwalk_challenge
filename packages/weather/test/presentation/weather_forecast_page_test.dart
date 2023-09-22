import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather/weather.dart';

import '../_utils/mocks.dart';

class MockCurrentWeatherCubit extends Mock implements CurrentWeatherCubit {}

void main() {
  testWidgets('Test WeatherForecastPage Widget', (WidgetTester tester) async {
    final mockInput = WeatherFetchingInput(
      cityName: faker.address.city(),
      latitude: faker.geo.latitude(),
      longitude: faker.geo.longitude(),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => CurrentWeatherCubit(MockFetchCurrentWeather())),
            BlocProvider(create: (_) => WeatherForecastCubit(MockFetchWeatherForecast())),
          ],
          child: WeatherForecastPage(input: mockInput),
        ),
      ),
    );

    expect(find.text(mockInput.cityName), findsOneWidget);
    expect(find.byType(PageHeaderWidget), findsOneWidget);
  });
}
