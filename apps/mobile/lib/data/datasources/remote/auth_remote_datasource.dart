import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:life_insurance_monitoring_mobile/core/errors/exceptions.dart';
import 'package:life_insurance_monitoring_mobile/data/datasources/local/auth_local_datasource.dart';
import 'package:life_insurance_monitoring_mobile/data/models/auth_response_model.dart';
import 'package:life_insurance_monitoring_mobile/core/constants/api_endpoints.dart';
import 'package:life_insurance_monitoring_mobile/data/models/user_registration_request_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthSessionModel> login(String email, String password);
  Future<void> logout();
  Future<void> refreshToken();
  Future<Map<String, dynamic>> registerUser(UserRegistrationRequestModel newUser);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({
    required this.dio,
  });

  final Dio dio;

  @override
  Future<AuthSessionModel> login(String email, String password) async {
    try {
      final response = await dio.post(
        ApiEndpoints.loginApi,
        data: {
          'email': email,
          'password': password,
        },
        options: Options(
          contentType: Headers.jsonContentType
        )
      );

      return AuthSessionModel.fromJson(response.data);
    } catch (e, stackTrace) {
      throw mapToAppException(e, stackTrace);
    }
  }

  @override
  Future<void> logout() async {
    final AuthLocalDataSourceImpl localDataSource = AuthLocalDataSourceImpl();

    final userId = await localDataSource.getUserId();
    final refreshToken = await localDataSource.getRefreshToken();

    try {
      await dio.post(ApiEndpoints.logoutApi, data: {
        'userId': userId,
        'refreshToken': refreshToken,
      });
    } catch (e, stackTrace) {
      throw mapToAppException(e, stackTrace);
    }
  }

  @override
  Future<void> refreshToken() async {
    final AuthLocalDataSourceImpl localDataSource = AuthLocalDataSourceImpl();

    final userId = await localDataSource.getUserId();
    final refreshToken = await localDataSource.getRefreshToken();

    try {
      final response = await dio.post(ApiEndpoints.refreshApi, data: {
        'userId': userId,
        'refreshToken': refreshToken,
      });

      if(response.statusCode == 200) {
        final session = AuthSessionModel.fromJson(response.data);
        await localDataSource.saveSession(session);
      } else {
        await localDataSource.clearSession();
        throw Exception("Your session has either expired, malformed, or something else must have gone wrong. Please login again.");
      }
    } catch (e, stackTrace) {
      throw mapToAppException(e, stackTrace);
    }
  }

  @override
  Future<Map<String, dynamic>> registerUser(UserRegistrationRequestModel newUser) async{
    try{
      final response = await dio.post(
        ApiEndpoints.registerApi,
        data: newUser.toJson(),
        options: Options(
          contentType: Headers.jsonContentType
        )
      );

      return response.data;
    }catch(e, stackTrace) {
      throw mapToAppException(e, stackTrace);
    }
  }
}