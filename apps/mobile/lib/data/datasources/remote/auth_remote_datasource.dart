import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:life_insurance_monitoring_mobile/core/errors/exceptions.dart';
import 'package:life_insurance_monitoring_mobile/data/models/auth_response_model.dart';
import 'package:life_insurance_monitoring_mobile/core/constants/api_endpoints.dart';
import 'package:life_insurance_monitoring_mobile/data/models/user_registration_request_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthSessionModel> login(String email, String password);
  Future<AuthSessionModel> logout(String userId, String refreshToken);
  Future<AuthSessionModel> refreshToken(String userId, String refreshToken);
  Future<Map<String, dynamic>> registerUser(
    UserRegistrationRequestModel newUser,
  );
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<AuthSessionModel> login(String email, String password) async {
    try {
      final response = await dio.post(
        ApiEndpoints.loginApi,
        data: {'email': email, 'password': password},
        options: Options(contentType: Headers.jsonContentType),
      );

      return AuthSessionModel.fromJson(response.data);
    } catch (e, stackTrace) {
      throw mapToAppException(e, stackTrace);
    }
  }

  @override
  Future<AuthSessionModel> logout(String userId, String refreshToken) async {
    try {
      final response = await dio.post(
        ApiEndpoints.logoutApi,
        data: {'userId': userId, 'refreshToken': refreshToken},
      );

      return AuthSessionModel.fromJson(response.data);
    } catch (e, stackTrace) {
      throw mapToAppException(e, stackTrace);
    }
  }

  @override
  Future<AuthSessionModel> refreshToken(String userId, String refreshToken) async {
    try {
      final response = await dio.post(
        ApiEndpoints.refreshApi,
        data: {'userId': userId, 'refreshToken': refreshToken},
      );

      if (response.statusCode == 200) {
        return AuthSessionModel.fromJson(response.data);
      } else {
        throw Exception(
          "Your session has either expired, malformed, or something else must have gone wrong. Please login again.",
        );
      }
    } catch (e, stackTrace) {
      throw mapToAppException(e, stackTrace);
    }
  }

  @override
  Future<Map<String, dynamic>> registerUser(
    UserRegistrationRequestModel newUser,
  ) async {
    try {
      final response = await dio.post(
        ApiEndpoints.registerApi,
        data: newUser.toJson(),
        options: Options(contentType: Headers.jsonContentType),
      );

      return response.data;
    } catch (e, stackTrace) {
      throw mapToAppException(e, stackTrace);
    }
  }
}
