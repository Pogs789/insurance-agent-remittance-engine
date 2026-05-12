import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:life_insurance_monitoring_mobile/domain/entities/user.dart';
import 'package:life_insurance_monitoring_mobile/domain/repositories/agent_repository.dart';
import 'package:life_insurance_monitoring_mobile/domain/repositories/auth_repository.dart';
import 'package:life_insurance_monitoring_mobile/domain/usecases/agent/agent_usecase.dart';
import 'package:life_insurance_monitoring_mobile/domain/usecases/auth/auth_usecases.dart';
import 'package:life_insurance_monitoring_mobile/main.dart';
import 'package:life_insurance_monitoring_mobile/presentation/providers/auth/auth_provider.dart';

class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository({this.initialLoggedIn = false});

  bool initialLoggedIn;

  @override
  Future<void> loginUser(String email, String password) async {}

  @override
  Future<bool> checkLoggedInUser() async => initialLoggedIn;

  @override
  Future<void> refreshToken() async {}

  @override
  Future<void> logout() async {
    initialLoggedIn = false;
  }
}

class FakeAgentRepository implements AgentRepository {
  @override
  Future<Map<String, dynamic>> registerUser(UserEntity newUser) async {
    return {'success': true};
  }
}

AuthProvider buildFakeAuthProvider({bool loggedIn = false}) {
  final authRepository = FakeAuthRepository(initialLoggedIn: loggedIn);
  final agentRepository = FakeAgentRepository();

  return AuthProvider(
    AgentUseCase(agentRepository),
    LoginUseCase(authRepository),
    RefreshTokenUseCase(authRepository),
    LogoutUseCase(authRepository),
    IsLoggedInUseCase(authRepository),
  );
}

Future<void> _pumpTestApp(WidgetTester tester, {bool loggedIn = false}) async {
  await tester.pumpWidget(AppBootstrap(authProvider: buildFakeAuthProvider(loggedIn: loggedIn),));
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
      await _pumpTestApp(tester);

      // Basic sanity: MaterialApp or WidgetsApp exists.
      expect(find.byType(MaterialApp), findsWidgets);
    });

    testWidgets('Home page loads', (WidgetTester tester) async {
      await _pumpTestApp(tester);

      // Example expectations; update to something stable on your home page.
      // e.g., expect(find.text('Home'), findsOneWidget);
      expect(find.byType(Scaffold), findsWidgets);
    });

    testWidgets('Insurance Remittance Calculation Loads', (
      WidgetTester tester,
    ) async {
      await _pumpTestApp(tester);

      final e = tester.takeException();
      expect(e, isNull, reason: 'Bootstrap failed before navigation: $e');

      await _openRoute(tester, routeName: '/');
      expect(tester.takeException(), isNull);
    });

    testWidgets('Login Page is Loaded', (WidgetTester tester) async {
      await _pumpTestApp(tester);

      final e = tester.takeException();
      expect(e, isNull, reason: 'Bootstrap failed before navigation: $e');

      await _openRoute(tester, routeName: '/login');
      expect(tester.takeException(), isNull);
    });

    testWidgets('Registration Page is Loaded', (WidgetTester tester) async {
      await _pumpTestApp(tester);

      final e = tester.takeException();
      expect(e, isNull, reason: 'Bootstrap failed before navigation: $e');

      await _openRoute(tester, routeName: '/register');
      expect(tester.takeException(), isNull);
    });
  });
}
