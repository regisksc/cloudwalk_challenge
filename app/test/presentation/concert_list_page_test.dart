import 'package:cloudwalk_challenge/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ConcertListPage widget test', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(home: ConcertListPage()),
    );

    expect(find.text('Next concerts'), findsOneWidget);
    expect(find.byType(ListTile), findsNWidgets(4));
    expect(find.byIcon(FeatherIcons.wifi), findsOneWidget);
    expect(find.byIcon(FeatherIcons.search), findsOneWidget);
  });
}
