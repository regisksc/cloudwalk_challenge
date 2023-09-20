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
    const initialArrowIconCount = 4;
    const initialLocationIconCount = 4;
    const initialAppBarIconCount = 2;
    const initialTotalIconCount = initialArrowIconCount + initialLocationIconCount + initialAppBarIconCount;

    expect(find.text('Next concerts'), findsOneWidget);
    expect(find.byType(ListTile), findsNWidgets(4));
    expect(find.byType(Icon), findsNWidgets(initialTotalIconCount));
    expect(find.byIcon(FeatherIcons.wifi), findsOneWidget);
    expect(find.byIcon(FeatherIcons.search), findsOneWidget);
  });
}
