import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather/weather.dart';

void main() {
  testWidgets('Test PageHeader Widget', (WidgetTester tester) async {
    const mockTitle = 'mockTitle';

    await tester.pumpWidget(const MaterialApp(
      home: PageHeaderWidget(title: mockTitle),
    ));

    expect(find.byType(PageHeaderWidget), findsOneWidget);

    await expectLater(
      find.byType(PageHeaderWidget),
      matchesGoldenFile('page_header_widget.png'),
    );
  });
}
