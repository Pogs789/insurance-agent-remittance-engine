class AppConstants {
  AppConstants._();

  // ── App Identity ──────────────────────────────────────────
  static const String appName = 'Remittance Calculator';
  static const String appVersion = '1.0.0';

  // ── Commission Defaults ───────────────────────────────────
  static const double minCommissionRate = 0.0;
  static const double maxCommissionRate = 100.0;

  // ── Pagination ────────────────────────────────────────────
  static const int maxRowsPerPage = 10;
  static const int defaultPage = 1;

  // ── Timeouts & Durations ──────────────────────────────────
  static const int splashDurationSeconds = 2;
  static const int loginDelaySeconds = 1;        // replaces hardcoded delay in login_page.dart
  static const int httpTimeoutSeconds = 30;

  // ── Route Names ───────────────────────────────────────────
  static const String routeSplash = '/';
  static const String routeRemittanceForm = '/remittance';
  static const String routeLogin = '/login';
  static const String routeRegister = '/register';
  static const String routeDashboard = '/dashboard';

  // ── UI ────────────────────────────────────────────────────
  static const double defaultPadding = 16.0;
  static const double cardBorderRadius = 12.0;

  //TODO: Also include here appropriate spacing for various types of devices (for both web and mobile app).
}