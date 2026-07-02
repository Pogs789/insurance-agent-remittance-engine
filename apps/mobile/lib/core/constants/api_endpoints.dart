class ApiEndpoints {
  // Base URL is configured via --dart-define=API_BASE_URL=<url> at build/run time.
  // For local development on an emulator use http://10.0.2.2:3000/api (Android)
  // or http://localhost:3000/api (iOS simulator / desktop).
  static final String _url = const String.fromEnvironment(
    'API_URL',
    defaultValue: 'http://localhost:3000',
  );

  static final String loginApi = '$_url/auth/login';
  static final String logoutApi = '$_url/auth/logout';
  static final String refreshApi = '$_url/auth/refresh';
  static final String registerApi = '$_url/auth/agent-register';

  static final String calculateMonthlyRemittance = '$_url/monthly-remittance';

  //Company API
  static final String getCompanyNamesAndCommissionRates = '$_url/company/public';
  static final String getCompanyInsuranceProductsApi = '$_url/policy-managements';
}
