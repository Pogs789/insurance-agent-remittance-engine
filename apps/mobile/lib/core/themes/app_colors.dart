import 'package:flutter/material.dart';

class AppColors {
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

  static const Color textPrimary = Color(
    0xFF111827,
  ); // main body textstatic const Color textSecondary = Color(0xFF4B5563); // supporting textstatic const Color textTertiary = Color(0xFF6B7280); // hints/placeholdersstatic const Color textDisabled = Color(0xFF9CA3AF); // disabled labelsstatic const Color textInverse = Colors.white; // text on dark surfacesstatic const Color textLink = Color(0xFF1D4ED8); // tappable inline text// -- Text Colors on Semantic Containers --------------------
  static const Color textOnSuccess = colorOnSuccessContainer;
  static const Color textOnError = colorOnErrorContainer;
  static const Color textOnWarning = colorOnWarningContainer;
  static const Color textOnInfo = colorOnInfoContainer;
}
