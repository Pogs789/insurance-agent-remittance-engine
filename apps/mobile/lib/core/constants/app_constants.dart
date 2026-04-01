import 'dart:ui';

import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();

  // ── Development Mode ──────────────────────────────────────
  static const bool isUnderDevelopment = true;

  // ── App Identity ──────────────────────────────────────────
  static const String appName = 'iRemitMo: The Insurance Agent\'s Remittance Calculator';
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

  // -- Responsive Breakpoints (logical pixels) --------------
  static const double mobileMaxWidth = 599.0;
  static const double tabletMinWidth = 600.0;
  static const double tabletMaxWidth = 1023.0;
  static const double webMinWidth = 1024.0;

  // -- Responsive Spacing -----------------------------------
  static const double mobilePadding = 16.0;
  static const double tabletPadding = 24.0;
  static const double webPadding = 32.0;

  // Maximum content width for centered web layouts
  static const double webContentMaxWidth = 1100.0;

  // Optional spacing scale for consistent widget gaps
  static const double spaceXS = 4.0;
  static const double spaceSM = 8.0;
  static const double spaceMD = 12.0;
  static const double spaceLG = 16.0;
  static const double spaceXL = 24.0;
  static const double spaceXXL = 32.0;

  // -- Typography Scale (base) -------------------------------
  static const double fontSizeXS = 12.0; // caption/helper
  static const double fontSizeSM = 14.0; // body small
  static const double fontSizeMD = 16.0; // body default
  static const double fontSizeLG = 18.0; // subtitle
  static const double fontSizeXL = 20.0; // section title
  static const double fontSizeXXL = 24.0; // page title
  static const double fontSizeDisplay = 32.0; // hero/landing

// -- Responsive Typography: Mobile -------------------------
  static const double mobileBodyFontSize = 14.0;
  static const double mobileLabelFontSize = 14.0;
  static const double mobileTitleFontSize = 20.0;
  static const double mobileHeadingFontSize = 24.0;

// -- Responsive Typography: Tablet -------------------------
  static const double tabletBodyFontSize = 15.0;
  static const double tabletLabelFontSize = 15.0;
  static const double tabletTitleFontSize = 22.0;
  static const double tabletHeadingFontSize = 28.0;

// -- Responsive Typography: Web ----------------------------
  static const double webBodyFontSize = 16.0;
  static const double webLabelFontSize = 16.0;
  static const double webTitleFontSize = 24.0;
  static const double webHeadingFontSize = 32.0;

// -- Special Numeric Emphasis ------------------------------
  static const double amountFontSizeMobile = 20.0;
  static const double amountFontSizeTablet = 22.0;
  static const double amountFontSizeWeb = 24.0;

  // -- Semantic Status Colors -------------------------------
  // Success: confirmations, completed calculations, saved history.
  static const Color colorSuccess = Color(0xFF15803D);
  static const Color colorOnSuccess = Colors.white;
  static const Color colorSuccessContainer = Color(0xFFDCFCE7);
  static const Color colorOnSuccessContainer = Color(0xFF14532D);

  // Error: validation failures, request failures, destructive states.
  static const Color colorError = Color(0xFFB91C1C);
  static const Color colorOnError = Colors.white;
  static const Color colorErrorContainer = Color(0xFFFEE2E2);
  static const Color colorOnErrorContainer = Color(0xFF7F1D1D);

  // Warning: incomplete inputs, risky edits, pending actions.
  static const Color colorWarning = Color(0xFFD97706);
  static const Color colorOnWarning = Colors.white;
  static const Color colorWarningContainer = Color(0xFFFFEDD5);
  static const Color colorOnWarningContainer = Color(0xFF7C2D12);

  // Info: hints, neutral process states, announcements.
  static const Color colorInfo = Color(0xFF1D4ED8);
  static const Color colorOnInfo = Colors.white;
  static const Color colorInfoContainer = Color(0xFFDBEAFE);
  static const Color colorOnInfoContainer = Color(0xFF1E3A8A);
}