class AuthSessionModel {
  const AuthSessionModel({
    required this.userId,
    required this.accessToken,
    required this.refreshToken,
  });

  final String userId;
  final String accessToken;
  final String refreshToken;

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'accessToken': accessToken,
    'refreshToken': refreshToken
  };

  factory AuthSessionModel.fromJson(Map<String, dynamic> json){
    return AuthSessionModel(
      userId: (json['userId'] ?? '').toString(),
      accessToken: (json['accessToken'] ?? '').toString(),
      refreshToken: (json['refreshToken'] ?? '').toString(),
    );
  }

  bool get hasValidAccessToken => accessToken.trim().isNotEmpty;
  bool get hasValidRefreshToken => refreshToken.trim().isNotEmpty;
}