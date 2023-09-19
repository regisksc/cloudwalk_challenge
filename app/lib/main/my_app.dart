import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

import '../presentation/presentation.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const concertListPage = ConcertListPage();
    return MaterialApp(
      restorationScopeId: 'app',
      debugShowCheckedModeBanner: false,
      initialRoute: WeatherForecastPage.routeName,
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) {
            final httpAdapter = HttpDatasource(client: Client(), baseUrl: 'api.openweathermap.org');
            final storage = CacheAdapter(const FlutterSecureStorage());
            return switch (routeSettings.name) {
              ConcertListPage.routeName => ConcertListBlocFactory.instance(
                  httpAdapter: httpAdapter,
                  storage: storage,
                  page: concertListPage,
                ),
              WeatherForecastPage.routeName => WeatherBlocFactory.instance(
                  httpAdapter: httpAdapter,
                  storage: storage,
                ),
              _ => const Offstage(),
            };
          },
        );
      },
    );
  }
}
