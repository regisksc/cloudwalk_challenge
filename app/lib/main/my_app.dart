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
            return switch (routeSettings.name) {
              ConcertListPage.routeName => concertListPage,
              _ => const Offstage(),
            };
          },
        );
      },
    );
  }
}
