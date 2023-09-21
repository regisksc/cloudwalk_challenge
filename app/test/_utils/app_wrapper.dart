import 'package:cities/cities.dart';
import 'package:cloudwalk_challenge/presentation/presentation.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks.dart';

Future<void> initApp(WidgetTester tester) async {
  await tester.pumpWidget(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: ConcertListBodyCubit(
            ConnectionHandleDecorator(
              cacheDecoratee: MockGeolocateCity(),
              remoteDecoratee: ErrorHandleDecorator<List<Geolocation>, GeolocationInput>(MockGeolocateCity()),
              connectivity: MockConnectivity(),
            ),
          ),
        )
      ],
      child: const MaterialApp(home: ConcertListPage()),
    ),
  );
}
