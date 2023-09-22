import 'package:cloudwalk_challenge/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather/weather.dart';

class FirstPageTests {
  FirstPageTests({required this.tester});

  final WidgetTester tester;
  static const cityName = 'Oslo';

  Future findInitialAppBarTitle() async {
    await tester.pump();
    expect(find.text(ConcertListPage.nextConcertsText), findsOneWidget);
  }

  Future<void> initiatesGeolocatingInitialList() async {
    await tester.pump();
    final loaderFinder = find.byType(CircularProgressIndicator);
    expect(loaderFinder, findsNWidgets(4));

    await tester.pumpAndSettle();

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byIcon(FeatherIcons.arrowRight), findsNWidgets(4));
  }

  Future<void> searchesForACity() async {
    await tester.tap(find.byIcon(FeatherIcons.search));
    await tester.pump();

    await tester.enterText(find.byType(TextField), cityName);
    await tester.pump(const Duration(seconds: 3));

    expect(find.text(cityName), findsOneWidget);
    expect(find.byType(ListTile), findsAtLeastNWidgets(1));

    await tester.testTextInput.receiveAction(TextInputAction.done); // dismisses keyboard
    await tester.pump();
  }

  Future tapSearchedCity() async {
    final buttonFinder = find.byKey(const Key('item_0'));
    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    expect(find.byType(WeatherForecastPage), findsOneWidget);
    expect(find.text(cityName), findsOneWidget);
  }
}
