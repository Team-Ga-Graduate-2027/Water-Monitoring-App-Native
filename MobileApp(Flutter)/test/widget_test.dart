// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutterapp/main.dart';

void main() {
  testWidgets('onboarding leads into the water dashboard', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const SalinSuriApp());
    await tester.pump(const Duration(milliseconds: 1500));
    await tester.pumpAndSettle();

    expect(find.text('Check Connection'), findsOneWidget);
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.text('Monitor Parameters'), findsOneWidget);
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.text('Track Changes'), findsOneWidget);
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    expect(find.text('Live Dashboard'), findsOneWidget);
    expect(find.text('Pre-filtration'), findsWidgets);
    expect(find.text('September 24 • 10:37 am'), findsOneWidget);
    expect(find.text('Battery Percentage:'), findsOneWidget);
    expect(find.text('29.6 °C'), findsOneWidget);
    expect(find.text('2.1 NTU'), findsOneWidget);
    expect(find.text('118 ppm'), findsOneWidget);
    expect(find.text('Water Quality Range'), findsOneWidget);
    expect(find.text('Monitoring Insights'), findsOneWidget);

    await tester.tap(find.text('See All →'));
    await tester.pumpAndSettle();
    expect(find.text('Sensors'), findsOneWidget);
    expect(find.text('Temperature'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.filter_alt_outlined).last);
    await tester.pumpAndSettle();
    expect(find.text('Filtration'), findsOneWidget);
    expect(find.text('Coconut Husk Fiber'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();
    expect(find.text('Device Connection'), findsOneWidget);
  });
}
