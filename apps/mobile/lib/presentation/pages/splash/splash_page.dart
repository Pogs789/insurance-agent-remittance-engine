import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth/auth_provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _didNavigate = false;

  @override
  Widget build(BuildContext context) {
	final authProvider = context.watch<AuthProvider>();
	final isResolved =
		authProvider.authStatus != AuthStatus.unknown && !authProvider.isLoading;

	if (isResolved && !_didNavigate) {
	  _didNavigate = true;
	  WidgetsBinding.instance.addPostFrameCallback((_) {
		if (!mounted) return;
		Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
	  });
	}

	return const Scaffold(
	  body: SafeArea(
		child: Center(
		  child: Column(
			mainAxisAlignment: MainAxisAlignment.center,
			children: [
			  CircularProgressIndicator(),
			  SizedBox(height: 16),
			  Text('Checking your session...'),
			],
		  ),
		),
	  ),
	);
  }
}

