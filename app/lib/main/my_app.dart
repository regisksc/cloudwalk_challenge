import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

import '../presentation/presentation.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const concertListPage = ConcertListPage();
    final httpAdapter = HttpDatasource(client: Client(), baseUrl: 'api.openweathermap.org');
    final storage = CacheAdapter(const FlutterSecureStorage());
    return MaterialApp(
      restorationScopeId: 'app',
      debugShowCheckedModeBanner: false,
      home: ConcertListBlocFactory.instance(
        httpAdapter: httpAdapter,
        storage: storage,
        page: concertListPage,
      ),
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) {
            return switch (routeSettings.name) {
              WeatherForecastPage.routeName => WeatherBlocFactory.instance(
                  httpAdapter: httpAdapter,
                  storage: storage,
                  args: routeSettings.arguments! as WeatherFetchingInput,
                ),
              _ => const Offstage(),
            };
          },
        );
      },
    );
  }
}
