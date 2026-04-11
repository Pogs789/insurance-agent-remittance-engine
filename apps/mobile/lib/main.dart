import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:life_insurance_monitoring_mobile/core/constants/app_constants.dart';
import 'package:life_insurance_monitoring_mobile/presentation/pages/auth/registration_page.dart';
import 'package:life_insurance_monitoring_mobile/presentation/pages/auth/login_page.dart';
import 'package:life_insurance_monitoring_mobile/presentation/pages/remittance/remittance_form_page.dart';
import 'core/themes/app_theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await dotenv.load(fileName: '.env');
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => const RemittanceFormPage(),
        '/register': (context) => const RegistrationPage(),
        '/login': (context) => const LoginPage()
      }
    );
  }
}
