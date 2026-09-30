import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:life_insurance_monitoring_mobile/core/constants/api_endpoints.dart';
import 'package:life_insurance_monitoring_mobile/data/datasources/local/auth_local_datasource.dart';
import 'package:life_insurance_monitoring_mobile/data/models/auth_response_model.dart';

class AuthInterceptor extends QueuedInterceptor {
  final AuthLocalDataSource authLocalDataSource;
  final Dio dio;
  final VoidCallback onSessionExpired;

  // Shared future used to deduplicate concurrent refresh attempts
  Future<void>? _refreshFuture;

  AuthInterceptor(this.authLocalDataSource, this.dio, {required this.onSessionExpired});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    debugPrint('Interceptor path: ${options.path}');
    final token = await authLocalDataSource.getAccessToken();
    debugPrint('Token found by interceptor: ${token != null && token.isNotEmpty}');
    debugPrint('Token found by interceptor: $token');

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
      debugPrint('[AuthInterceptor] Authorization header attached');
    } else {
      debugPrint('[AuthInterceptor] No token found in storage');
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;
    final requestOptions = err.requestOptions;

    debugPrint("Processing Dio Error... Status Code: $statusCode");
    debugPrint("Is Retried: ${requestOptions.extra['retried']}");

    if (statusCode == 401 && requestOptions.extra['retried'] != true) {
      debugPrint("[AuthInterceptor] Attempting token refresh...");
      try {
        if (_refreshFuture != null) {
          debugPrint("[AuthInterceptor] Waiting for ongoing refresh...");
          await _refreshFuture;
        } else {
          debugPrint("[AuthInterceptor] Starting new refresh execution...");
          _refreshFuture = _refreshToken();
          await _refreshFuture;
        }
        debugPrint("[AuthInterceptor] Refresh successful!");
      } catch (e, stackTrace) {
        debugPrint("[AuthInterceptor] Refresh failed with error: $e");
        debugPrint(stackTrace.toString());
        _refreshFuture = null;
        onSessionExpired();
        return handler.next(err);
      } finally {
        _refreshFuture = null;
      }

      try {
        final newToken = await authLocalDataSource.getAccessToken();
        debugPrint("[AuthInterceptor] Retrying original request with new token: ${newToken != null}");

        // Mark request as retried
        requestOptions.extra['retried'] = true;
        requestOptions.headers['Authorization'] = 'Bearer $newToken';

        // Re-fetch using dio instance
        final response = await dio.fetch(requestOptions);
        return handler.resolve(response);
      } on DioException catch (e) {
        debugPrint("[AuthInterceptor] Retried request failed with DioException");
        return handler.next(e);
      } catch (e) {
        debugPrint("[AuthInterceptor] Retried request failed with generic error");
        return handler.next(err);
      }
    }

    debugPrint("[AuthInterceptor] Skipping refresh logic. Forwarding error.");
    handler.next(err);
  }

  Future<void> _refreshToken() async {
    final session = await authLocalDataSource.getSession();
    
    if (session == null || session.userId.isEmpty || session.refreshToken.isEmpty) {
      throw Exception('Missing session credentials for token refresh');
    }

    final refreshDio = Dio();

    try {
      final response = await refreshDio.post(
        ApiEndpoints.refreshApi,
        data: {'userId': session.userId, 'refreshToken': session.refreshToken},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final newAccess = data['access_token'] ?? data['accessToken'] ?? data['access'];
        final newRefresh = data['refresh_token'] ?? data['refreshToken'] ?? data['refresh'];

        if (newAccess != null || newRefresh != null) {
          final updatedSession = AuthSessionModel(
            userId: session.userId,
            companyId: session.companyId,
            fullName: session.fullName,
            insuranceCompany: session.insuranceCompany,
            accessToken: newAccess?.toString() ?? session.accessToken,
            refreshToken: newRefresh?.toString() ?? session.refreshToken,
            userRole: session.userRole,
            commissionRate: session.commissionRate,
          );
          await authLocalDataSource.saveSession(updatedSession);
        }
      }
    } on DioException catch (_) {
      rethrow;
    }
  }
}