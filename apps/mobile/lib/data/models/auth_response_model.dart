class AuthSessionModel {
  const AuthSessionModel({
    required this.userId,
    required this.fullName,
    required this.insuranceCompany,
    required this.accessToken,
    required this.refreshToken,
  });

  final String userId;
  final String fullName;
  final String insuranceCompany;
  final String accessToken;
  final String refreshToken;

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'fullName': fullName,
    'insuranceCompany': insuranceCompany,
    'accessToken': accessToken,
    'refreshToken': refreshToken,
  };

  /// Parses a login response where [userId] is nested under `user.id`.
  factory AuthSessionModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>?;
    return AuthSessionModel(
      userId: (user?['id'] ?? '').toString(),
      fullName: (user?['fullName'] ?? '').toString(),
      insuranceCompany: (user?['insuranceCompany'] ?? '').toString(),
      accessToken: (json['accessToken'] ?? '').toString(),
      refreshToken: (json['refreshToken'] ?? '').toString(),
    );
  }

  /// Parses a token-refresh response that returns only new tokens (no user object).
  factory AuthSessionModel.fromJsonTokensOnly(
    Map<String, dynamic> json,
    String userId,
  ) {
    return AuthSessionModel(
      userId: userId,
      fullName: (json['fullName'] ?? '').toString(),
      insuranceCompany: (json['insuranceCompany'] ?? '').toString(),
      accessToken: (json['accessToken'] ?? '').toString(),
      refreshToken: (json['refreshToken'] ?? '').toString(),
    );
  }

  bool get hasValidAccessToken => accessToken.trim().isNotEmpty;
  bool get hasValidRefreshToken => refreshToken.trim().isNotEmpty;
}
