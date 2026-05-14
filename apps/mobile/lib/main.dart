import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
import 'package:provider/provider.dart';
import 'core/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final authProvider = buildRealAuthProvider();

  if (!kIsWeb) {
    await dotenv.load(fileName: '.env');
  }

  runApp(AppBootstrap(authProvider: authProvider));
}

AuthProvider buildRealAuthProvider() {
  final dio = Dio();

  // Data sources
  final authRemote = AuthRemoteDataSourceImpl(dio: dio);
  final authLocal = AuthLocalDataSourceImpl();

  // Repositories
  final authRepository = AuthRepositoryImpl(authRemote, authLocal);
  final agentRepository = AgentRepositoryImpl(authRemote);

  // Use cases
  final submitAgentUseCase = AgentUseCase(agentRepository);
  final loginUseCase = LoginUseCase(authRepository);
  final refreshTokenUseCase = RefreshTokenUseCase(authRepository);
  final logoutUseCase = LogoutUseCase(authRepository);
  final isLoggedInUseCase = IsLoggedInUseCase(authRepository);

  // Provider
  return AuthProvider(
    submitAgentUseCase,
    loginUseCase,
    refreshTokenUseCase,
    logoutUseCase,
    isLoggedInUseCase,
  );
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
  Future<bool>? _isLoggedInFuture;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isLoggedInFuture = context.read<AuthProvider>().isLoggedIn();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool?>(
      future: _isLoggedInFuture,
      builder: (context, snapshot) {
        final initialRoute =
            snapshot.hasData && snapshot.data == true ? '/dashboard' : '/';

        return MaterialApp(
          title: AppConstants.appName,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.system,
          //initialRoute: initialRoute,
          initialRoute: '/dashboard',
          routes: {
            '/': (_) => const RemittanceFormPage(),
            '/register': (_) => const RegistrationPage(),
            '/login': (_) => const LoginPage(),
            '/dashboard': (_) => const DashboardPage(),
            '/remittance-history': (_) => const Placeholder(),
          },
        );
      },
    );
  }
}
