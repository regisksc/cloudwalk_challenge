import 'package:cities/cities.dart';
import 'package:cloudwalk_challenge/presentation/presentation.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_utils/app_wrapper.dart';
import '../../bloc/body/concert_list_body_cubit_test.dart';

class MockConcertListBodyCubit extends Mock implements ConcertListBodyCubit {}

class MockGeolocateCity extends Mock implements Usecase<List<Geolocation>, GeolocationInput> {}

void main() {
  group('ShowInitialListFab Widget Test', () {
    late MockConcertListBodyCubit mockCubit;

    setUp(() {
      mockCubit = MockConcertListBodyCubit();
    });

    

    testWidgets('Widget should be visible when state is DataFetched', (WidgetTester tester) async {
      when(() => mockCubit.state).thenReturn(DataFetched(<Geolocation>[MockGeolocation()]));
      await initApp(tester);
      expect(find.byType(Visibility), findsOneWidget);
    });

    testWidgets('Widget should call geolocalizeStartingList when tapped', (WidgetTester tester) async {
      when(() => mockCubit.state).thenReturn(DataFetched(<Geolocation>[MockGeolocation()]));
      when(() => mockCubit.geolocalizeStartingList()).thenAnswer((_) async => Future.value());

      await initApp(tester);

      await tester.pumpAndSettle();
      final inkWellFinder = find.byType(Visibility);

      expect(inkWellFinder, findsOneWidget);
      await tester.tap(inkWellFinder, warnIfMissed: false);
      await tester.pump();
    });

    testWidgets('Widget should not be visible when state is not DataFetched', (WidgetTester tester) async {
      when(() => mockCubit.state).thenReturn(NextConcerts(initialCities: <Geolocation>[MockGeolocation()]));
      await initApp(tester);

      expect(find.text('show next concerts').hitTestable(), findsNothing);
    });
  });
}
