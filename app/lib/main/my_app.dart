import 'package:core/core.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_framework.dart';
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
      builder: (context, child) {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
        return ResponsiveBreakpoints.builder(
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
          child: DevicePreview.appBuilder(context, child),
        );
      },
      theme: Theme.of(context).copyWith(iconTheme: IconThemeData(size: MediaQuery.of(context).size.longestSide * 0.04)),
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
