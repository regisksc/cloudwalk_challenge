import 'package:cities/cities.dart';
import 'package:cloudwalk_challenge/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../_utils/app_wrapper.dart';
import '../../../bloc/body/concert_list_body_cubit_test.dart';

void main() {
  testWidgets('list_body', (WidgetTester tester) async {
    final geolocaton = Geolocation(name: 'test', modifiedWhen: DateTime.now());
    final list = [geolocaton];
    final bloc = ConcertListBodyCubit(MockGeolocateCity());
    final initialState = NextConcerts(initialCities: list);

    await initApp(tester);

    bloc.emit(initialState);

    expect(find.byType(BodyList), findsOneWidget);

    await expectLater(
      find.byType(BodyList),
      matchesGoldenFile('list_body.png'),
    );

    await tester.tap(find.byType(ListTile).at(0));
    await tester.pump();
  });
}
