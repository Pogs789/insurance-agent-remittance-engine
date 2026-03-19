import 'package:dio/dio.dart';
import 'package:life_insurance_monitoring_mobile/data/models/auth_response_model.dart';
import 'package:life_insurance_monitoring_mobile/core/constants/api_endpoints.dart';

abstract class AuthRemoteDataSource {
  Future<AuthSessionModel> login(String email, String password);
  Future<void> logout();
  Future<AuthSessionModel> refreshToken(String refreshToken);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({
    required this.httpClient,
  });

  final Dio dio;

  @override
  Future<AuthSessionModel> login(String email, String password) async {
    try {
      final response = await dio.post(ApiEndpoints.loginApi, data: {
        'email': email,
        'password': password,
      });

      return AuthSessionModel.fromJson(response.data);
    }catch(e, stackTrace) {
      throw Exception('Login Failed: $e. Stack Trace: $stackTrace'); //TODO: This is temporary. Because Dio has many responses that needed to be caught. Implement errors from constants.
    }
  }

  @override
  Future<void> logout(String userId, String refreshToken) async {
    try {
      await dio.post(ApiEndpoints.logoutApi, data: {
        'userId': userId,
        'refreshToken': refreshToken
      });
    }catch(e, stackTrace) {
      throw Exception('Logout Failed: $e. Stack Trace: $stackTrace'); //TODO: This is temporary. Because Dio has many responses that needed to be caught. Implement errors from constants.
    }
  }

  @override
  Future<AuthSessionModel> refreshToken
}