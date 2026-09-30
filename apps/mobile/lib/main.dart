import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:life_insurance_monitoring_mobile/core/constants/app_constants.dart';
import 'package:life_insurance_monitoring_mobile/data/datasources/local/auth_local_datasource.dart';
import 'package:life_insurance_monitoring_mobile/data/datasources/remote/auth_remote_datasource.dart';
import 'package:life_insurance_monitoring_mobile/data/repositories/agent_repository.dart';
import 'package:life_insurance_monitoring_mobile/data/repositories/auth_repository.dart';
import 'package:life_insurance_monitoring_mobile/domain/usecases/agent/agent_usecase.dart';
import 'package:life_insurance_monitoring_mobile/domain/usecases/auth/auth_usecases.dart';
import 'package:life_insurance_monitoring_mobile/presentation/providers/auth/auth_provider.dart';
import 'package:life_insurance_monitoring_mobile/presentation/pages/auth/registration_page.dart';
import 'package:life_insurance_monitoring_mobile/presentation/pages/auth/login_page.dart';
import 'package:life_insurance_monitoring_mobile/presentation/pages/dashboard/dashboard_page.dart';
import 'package:life_insurance_monitoring_mobile/presentation/pages/remittance/remittance_form_page.dart';
import 'package:life_insurance_monitoring_mobile/presentation/pages/splash/splash_page.dart';
import 'package:provider/provider.dart';
import 'core/themes/app_theme.dart';
import 'package:life_insurance_monitoring_mobile/core/network/interceptors.dart';

import 'package:life_insurance_monitoring_mobile/core/app_globals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authProvider = buildRealAuthProvider();

  runApp(AppBootstrap(authProvider: authProvider));
}

AuthProvider buildRealAuthProvider() {
  final session = AuthLocalDataSourceImpl();
  final dio = Dio();
  setAppDio(dio);

  // Create an uninitialized pointer for AuthProvider
  late final AuthProvider authProvider;

  // Pass a lazy callback to the interceptor that references our provider
  dio.interceptors.add(
    AuthInterceptor(
      session,
      dio,
      onSessionExpired: () => authProvider.handleForceLogout(),
    ),
  );

  final authRemote = AuthRemoteDataSourceImpl(dio: dio);
  final authLocal = AuthLocalDataSourceImpl();

  final authRepository = AuthRepositoryImpl(authRemote, authLocal);
  final agentRepository = AgentRepositoryImpl(authRemote);

  final submitAgentUseCase = AgentUseCase(agentRepository);
  final loginUseCase = LoginUseCase(authRepository);
  final refreshTokenUseCase = RefreshTokenUseCase(authRepository);
  final logoutUseCase = LogoutUseCase(authRepository);
  final isLoggedInUseCase = IsLoggedInUseCase(authRepository);

  // Initialize the late variable here
  authProvider = AuthProvider(
    submitAgentUseCase,
    loginUseCase,
    refreshTokenUseCase,
    logoutUseCase,
    isLoggedInUseCase,
  );

  return authProvider;
}

class AppBootstrap extends StatelessWidget {
  final AuthProvider authProvider;
  const AppBootstrap({super.key, required this.authProvider});
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>.value(
      value: authProvider,
      child: const MyAppShell(),
    );
  }
}

class MyAppShell extends StatefulWidget {
  const MyAppShell({super.key});

  @override
  State<MyAppShell> createState() => _MyAppShellState();
}

class _MyAppShellState extends State<MyAppShell> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = context.read<AuthProvider>();

      authProvider.setSessionExpiredCallback(() {
        navigatorKey.currentState?.pushNamedAndRemoveUntil(
          '/login',
              (route) => false,
        );
      });

      authProvider.initializeAuth();
    });
  }

  bool _isProtectedRoute(String routeName) {
    return routeName == '/dashboard' || routeName == '/remittance-history';
  }

  Route<dynamic> _generateRoute(RouteSettings settings, AuthProvider authProvider) {
    final requestedRoute = settings.name ?? '/';

    // 1. If we are actively checking credentials, force everyone to the splash screen
    final isCheckingAuth = authProvider.authStatus == AuthStatus.unknown || authProvider.isLoading;
    if (isCheckingAuth) {
      return MaterialPageRoute(
        settings: const RouteSettings(name: '/splash'),
        builder: (_) => const SplashPage(),
      );
    }

    final isAuthenticated = authProvider.isLoggedInSync;
    String resolvedRoute = requestedRoute;

    // 2. Route redirection based on actual auth states
    if (isAuthenticated) {
      // If logged in, block them from landing/auth pages and send to dashboard
      if (requestedRoute == '/' || requestedRoute == '/login' || requestedRoute == '/register' || requestedRoute == '/splash') {
        resolvedRoute = '/dashboard';
      }
    } else {
      // If NOT logged in, block them from protected routes or getting stuck on splash
      if (requestedRoute == '/splash' || _isProtectedRoute(requestedRoute)) {
        resolvedRoute = '/login'; // Or '/' depending on your default guest landing page
      }
    }

    // 3. Render the page based on the final resolved route
    return MaterialPageRoute(
      settings: RouteSettings(name: resolvedRoute, arguments: settings.arguments),
      builder: (_) {
        switch (resolvedRoute) {
          case '/splash':
            return const SplashPage();
          case '/':
            return const RemittanceFormPage();
          case '/register':
            return const RegistrationPage();
          case '/login':
            return const LoginPage();
          case '/dashboard':
            return const DashboardPage();
          case '/remittance-history':
            return const Placeholder();
          default:
            return const RemittanceFormPage();
        }
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        return MaterialApp(
          title: AppConstants.appName,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.system,
          onGenerateRoute: (settings) => _generateRoute(settings, authProvider),
          initialRoute: '/',
        );
      },
    );
  }
}
