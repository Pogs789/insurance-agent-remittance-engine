class ApiEndpoints {
  // Base URL is configured via --dart-define=API_BASE_URL=<url> at build/run time.
  // For local development on an emulator use http://10.0.2.2:3000/api (Android)
  // or http://localhost:3000/api (iOS simulator / desktop).
  static const String _url = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:3000/api',
  );

  static const String loginApi = '$_url/auth/login';
  static const String logoutApi = '$_url/auth/logout';
  static const String refreshApi = '$_url/auth/refresh';
}