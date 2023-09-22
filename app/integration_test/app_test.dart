import 'package:cloudwalk_challenge/main/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'test_cases/first_page_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  FirstPageTests firstPage;
  group('main flow test', () {
    testWidgets('main flow', (widgetTester) async {
      firstPage = FirstPageTests(tester: widgetTester);
      app.main();

      await firstPage.findInitialAppBarTitle();
      await firstPage.initiatesGeolocatingInitialList();
      await firstPage.searchesForACity();
      await firstPage.tapSearchedCity();
    });
  });
}
