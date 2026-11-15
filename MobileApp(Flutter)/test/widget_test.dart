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

    await tester.ensureVisible(find.text('pH Level Monitoring'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('pH Level Monitoring'));
    await tester.pumpAndSettle();
    expect(find.text('Pre-filtration'), findsWidgets);
    expect(find.text('Post-filtration'), findsWidgets);
    await tester.ensureVisible(find.text('View details').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('View details').first);
    await tester.pumpAndSettle();
    expect(find.text('pH Level Chart'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('See All →'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('See All →'));
    await tester.pumpAndSettle();
    expect(find.text('Sensors'), findsOneWidget);
    expect(find.text('Temperature'), findsWidgets);
    expect(find.byTooltip('Back'), findsOneWidget);
    expect(find.byTooltip('Notifications'), findsOneWidget);
    expect(
      tester.getRect(find.byTooltip('Back')).right,
      lessThan(tester.getRect(find.byTooltip('Notifications')).left),
    );
    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.filter_alt_outlined).last);
    await tester.pumpAndSettle();
    expect(find.text('Filtration'), findsOneWidget);
    expect(find.text('Coconut Husk Fiber'), findsOneWidget);
    await tester.tap(find.byTooltip('About Coconut Husk Fiber'));
    await tester.pumpAndSettle();
    expect(find.text('What is it?'), findsOneWidget);
    await tester.tap(find.text('Next →'));
    await tester.pumpAndSettle();
    expect(find.text('Why is it used?'), findsOneWidget);
    await tester.tap(find.text('Close').last);
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Filtration Insights'),
      250,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    expect(find.text('Filtration Insights'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Filtration History'),
      250,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Filtration History'));
    await tester.pumpAndSettle();
    expect(find.text('Filtration #129'), findsOneWidget);
    await tester.tap(find.text('Filtration #129'));
    await tester.pumpAndSettle();
    expect(find.text('Monitoring Report'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.notifications_none_rounded).last);
    await tester.pumpAndSettle();
    expect(find.text('Notification'), findsWidgets);
    expect(find.text('Maintenance Alert'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();
    expect(find.text('Device Connection'), findsOneWidget);
    expect(
      Theme.of(tester.element(find.text('Device Connection'))).brightness,
      Brightness.dark,
    );
    await tester.tap(find.byType(Switch).first);
    await tester.pumpAndSettle();
    expect(
      Theme.of(tester.element(find.text('Device Connection'))).brightness,
      Brightness.light,
    );
    await tester.tap(find.byType(Switch).last);
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.notifications_none_rounded).last);
    await tester.pumpAndSettle();
    expect(find.textContaining('Notifications are turned off'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(Switch).last);
    await tester.pumpAndSettle();
    await tester.tap(find.byType(Switch).first);
    await tester.pumpAndSettle();
    expect(
      Theme.of(tester.element(find.text('Device Connection'))).brightness,
      Brightness.dark,
    );
  });
}
