import 'package:dio/dio.dart';
import 'package:life_insurance_monitoring_mobile/core/errors/exceptions.dart';
import 'package:life_insurance_monitoring_mobile/data/models/auth_response_model.dart';
import 'package:life_insurance_monitoring_mobile/core/constants/api_endpoints.dart';

abstract class AuthRemoteDataSource {
  Future<AuthSessionModel> login(String email, String password);
  Future<void> logout(String userId, String refreshToken);
  Future<AuthSessionModel> refreshToken(String userId, String refreshToken);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({
    required this.dio,
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
    } catch (e, stackTrace) {
      //TODO: This is temporary. Because Dio has many responses that needed to be caught. Implement errors from constants.
      Error.throwWithStackTrace(mapToAppException(e, stackTrace), stackTrace);
    }
  }

  @override
  Future<void> logout(String userId, String refreshToken) async {
    try {
      await dio.post(ApiEndpoints.logoutApi, data: {
        'userId': userId,
        'refreshToken': refreshToken,
      });
    } catch (e, stackTrace) {
      //TODO: This is temporary. Because Dio has many responses that needed to be caught. Implement errors from constants.
      Error.throwWithStackTrace(mapToAppException(e, stackTrace), stackTrace);
    }
  }

  @override
  Future<AuthSessionModel> refreshToken(String userId, String refreshToken) async {
    try {
      final response = await dio.post(ApiEndpoints.refreshApi, data: {
        'userId': userId,
        'refreshToken': refreshToken,
      });

      return AuthSessionModel.fromJsonTokensOnly(response.data, userId);
    } catch (e, stackTrace) {
      //TODO: This is temporary. Because Dio has many responses that needed to be caught. Implement errors from constants.
      Error.throwWithStackTrace(mapToAppException(e, stackTrace), stackTrace);
    }
  }
}