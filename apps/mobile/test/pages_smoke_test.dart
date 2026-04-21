// File: `test/pages_smoke_test.dart`
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Adjust this import to your app entrypoint.
import 'package:life_insurance_monitoring_mobile/main.dart';

Future<void> _pumpApp(WidgetTester tester) async {
  await tester.pumpWidget(const MyApp());
  await tester.pumpAndSettle();
}

/// Navigates using a named route from the app's initial screen.
/// This assumes your app uses Navigator routes and the route is reachable.
Future<void> _openRoute(
  WidgetTester tester, {
  required String routeName,
}) async {
  final navigator = find.byType(Navigator);
  expect(navigator, findsOneWidget);

  // Push route via navigator state.
  final navState = tester.state<NavigatorState>(navigator);
  navState.pushNamed(routeName);
  await tester.pumpAndSettle();
}

void main() {
  group('Page smoke tests', () {
    testWidgets('App launches', (WidgetTester tester) async {
      await _pumpApp(tester);

      // Basic sanity: MaterialApp or WidgetsApp exists.
      expect(find.byType(MaterialApp), findsWidgets);
    });

    // TODO: Replace route names and expectations with your real pages.
    testWidgets('Home page loads', (WidgetTester tester) async {
      await _pumpApp(tester);

      // Example expectations; update to something stable on your home page.
      // e.g., expect(find.text('Home'), findsOneWidget);
      expect(find.byType(Scaffold), findsWidgets);
    });

    testWidgets('Insurance Remittance Calculation Loads', (
      WidgetTester tester,
    ) async {
      await _pumpApp(tester);

      await _openRoute(tester, routeName: '/');
      expect(tester.takeException(), isNull);
    });

    testWidgets('Login Page is Loaded', (WidgetTester tester) async {
      await _pumpApp(tester);

      await _openRoute(tester, routeName: '/login');
      expect(tester.takeException(), isNull);
    });

    testWidgets('Registration Page is Loaded', (WidgetTester tester) async {
      await _pumpApp(tester);

      await _openRoute(tester, routeName: '/register');
      expect(tester.takeException(), isNull);
    });
  });
}
