import 'package:cities/cities.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../presentation/presentation.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const concertListPage = ConcertListPage();
    return MaterialApp(
      restorationScopeId: 'app',
      debugShowCheckedModeBanner: false,
      home: concertListPage,
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) {
            final httpAdapter = HttpDatasource(client: Client(), baseUrl: 'api.openweathermap.org');
            return switch (routeSettings.name) {
              ConcertListPage.routeName => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: ConcertListBodyCubit(
                        ErrorHandleDecorator<City, City>(RemotelyGeolocateCity(httpAdapter)) as GeolocateCity,
                      ),
                    ),
                  ],
                  child: concertListPage,
                ),
              _ => const Offstage(),
            };
          },
        );
      },
    );
  }
}
