import 'package:cities/cities.dart';
import 'package:cloudwalk_challenge/presentation/presentation.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGeolocateCity extends Mock implements Usecase<List<Geolocation>, GeolocationInput> {}

void main() {
  testWidgets('ConcertListPage widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: ConcertListBodyCubit(
              ErrorHandleDecorator<List<Geolocation>, GeolocationInput>(MockGeolocateCity()),
              MockGeolocateCity(),
            ),
          )
        ],
        child: const MaterialApp(home: ConcertListPage()),
      ),
    );

    expect(find.text('Next concerts'), findsOneWidget);
    expect(find.byType(ListTile), findsNWidgets(4));
    expect(find.byIcon(FeatherIcons.wifi), findsOneWidget);
    expect(find.byIcon(FeatherIcons.search), findsOneWidget);
  });
}
