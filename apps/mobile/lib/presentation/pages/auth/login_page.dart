import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:life_insurance_monitoring_mobile/core/constants/app_constants.dart';
import 'package:life_insurance_monitoring_mobile/presentation/pages/auth/registration_page.dart';
import 'package:life_insurance_monitoring_mobile/core/themes/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:life_insurance_monitoring_mobile/presentation/providers/auth/auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:life_insurance_monitoring_mobile/data/datasources/local/auth_local_datasource.dart';
import 'package:life_insurance_monitoring_mobile/data/datasources/remote/auth_remote_datasource.dart';
import 'package:life_insurance_monitoring_mobile/data/repositories/agent_repository.dart';
import 'package:life_insurance_monitoring_mobile/data/repositories/auth_repository.dart';
import 'package:life_insurance_monitoring_mobile/domain/usecases/agent/agent_usecase.dart';
import 'package:life_insurance_monitoring_mobile/domain/usecases/auth/auth_usecases.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // We use standard controllers for the Prototype phase
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Toggle for password visibility
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin(BuildContext providerContext) async {
    if (_formKey.currentState!.validate()) {
      final provider = providerContext.read<AuthProvider>();

      await provider.login(_emailController.text, _passwordController.text);

      if(!providerContext.mounted) return;

      if(provider.isSuccess == true) {
        Navigator.pushNamedAndRemoveUntil(providerContext, '/dashboard', (route) => false);
        return;
      }

      ScaffoldMessenger.of(providerContext).showMaterialBanner(
        MaterialBanner(
          content: Text(provider.errorMessage ?? "An unexpected error occurred while processing your request. Please Try Again."),
          actions: [
            TextButton(onPressed: () => ScaffoldMessenger.of(providerContext).hideCurrentMaterialBanner(), child: Text("Close"))
          ],
          backgroundColor: AppColors.colorError,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(
        AgentUseCase(AgentRepositoryImpl(AuthRemoteDataSourceImpl(dio: Dio()))),
        LoginUseCase(AuthRepositoryImpl(AuthRemoteDataSourceImpl(dio: Dio()), AuthLocalDataSourceImpl())),
        RefreshTokenUseCase(
          AuthRepositoryImpl(AuthRemoteDataSourceImpl(dio: Dio()), AuthLocalDataSourceImpl()),
        ),
        LogoutUseCase(AuthRepositoryImpl(AuthRemoteDataSourceImpl(dio: Dio()), AuthLocalDataSourceImpl())),
      ),
        child: Builder(
          builder: (providerContext) {
            final provider = providerContext.watch<AuthProvider>();

            return Scaffold(
              // Using Safe Area to avoid notches
              appBar: AppBar(title: Text('iRemitMo Login')),
              body: SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // 1. Logo or Header
                          const Icon(
                            Icons.lock_person_outlined,
                            size: 80,
                            color: Colors.blueAccent,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Welcome Back',
                            style: Theme
                                .of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Sign in to access the dashboard',
                            style: Theme
                                .of(
                              context,
                            )
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 48),

                          // 2. Email Field
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Email Address',
                              prefixIcon: Icon(Icons.email_outlined),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // 3. Password Field
                          TextFormField(
                            controller: _passwordController,
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock_outline),
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 24),

                          // 4. Login Button
                          SizedBox(
                            height: 50, // Standard touch target height
                            child: ElevatedButton(
                              onPressed: provider.isLoading ?
                                null : () async {
                                  // if (AppConstants.isUnderDevelopment) {
                                  //   ScaffoldMessenger.of(context).showSnackBar(
                                  //     SnackBar(
                                  //       content: Text(
                                  //         'Tool upgrades are underway to boost your productivity, agent. Please stay tuned.',
                                  //       ),
                                  //       backgroundColor: AppColors.colorWarning,
                                  //     ),
                                  //   );
                                  //
                                  //   return;
                                  // }
                                  _handleLogin(providerContext);
                                },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          TextButton(
                            onPressed: () =>
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegistrationPage(),
                                  ),
                                ),
                            child: Text('New Agent? Register now!'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          })
    );
  }
}
