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

    testWidgets('Login page loads', (WidgetTester tester) async {
      await _pumpApp(tester);
      await _openRoute(tester, routeName: '/login');

      // Replace with stable widgets used on the Login page.
      // e.g., expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(Scaffold), findsWidgets);
    });

    testWidgets('Register page loads', (WidgetTester tester) async {
      await _pumpApp(tester);
      await _openRoute(tester, routeName: '/register');

      expect(find.byType(Scaffold), findsWidgets);
    });

    testWidgets('Dashboard page loads', (WidgetTester tester) async {
      await _pumpApp(tester);
      await _openRoute(tester, routeName: '/dashboard');

      expect(find.byType(Scaffold), findsWidgets);
    });

    testWidgets('Policies page loads', (WidgetTester tester) async {
      await _pumpApp(tester);
      await _openRoute(tester, routeName: '/policies');

      expect(find.byType(Scaffold), findsWidgets);
    });

    testWidgets('Policy details page loads', (WidgetTester tester) async {
      await _pumpApp(tester);

      // If details requires arguments, push using RouteSettings.
      final navState = tester.state<NavigatorState>(find.byType(Navigator));
      navState.pushNamed(
        '/policy-details',
        arguments: {'id': 'test-id'},
      );
      await tester.pumpAndSettle();

      expect(find.byType(Scaffold), findsWidgets);
    });

    testWidgets('Profile page loads', (WidgetTester tester) async {
      await _pumpApp(tester);
      await _openRoute(tester, routeName: '/profile');

      expect(find.byType(Scaffold), findsWidgets);
    });

    testWidgets('Settings page loads', (WidgetTester tester) async {
      await _pumpApp(tester);
      await _openRoute(tester, routeName: '/settings');

      expect(find.byType(Scaffold), findsWidgets);
    });
  });
}