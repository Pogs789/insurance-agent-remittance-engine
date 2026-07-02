import 'package:flutter/material.dart';
import 'package:life_insurance_monitoring_mobile/data/datasources/local/auth_local_datasource.dart';
import 'package:life_insurance_monitoring_mobile/domain/repositories/auth_repository.dart';
import '../datasources/remote/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemote;
  final AuthLocalDataSource authLocal;
  AuthRepositoryImpl(this.authRemote, this.authLocal);

  @override
  Future<void> loginUser(String email, String password) async {
    final response = await authRemote.login(email, password);
    await authLocal.saveSession(response);
  }

  @override
  Future<void> logout() async {
    final String? userId = await authLocal.getUserId();
    final String? refreshToken = await authLocal.getRefreshToken();

    if (userId == null || refreshToken == null) {
      await authLocal.clearSession();
      return;
    }

    await authRemote.logout(userId, refreshToken);
    await authLocal.clearSession();
  }

  @override
  Future<void> refreshToken() async {
    final String? userId = await authLocal.getUserId();
    final String? refreshToken = await authLocal.getRefreshToken();

    if (userId == null || refreshToken == null) {
      await authLocal.clearSession();
      return;
    }

    final refreshedSession = await authRemote.refreshToken(userId, refreshToken);
    await authLocal.saveSession(refreshedSession);
  }

  @override
  Future<bool> checkLoggedInUser() async {
    final session = await authLocal.getSession();
    final loggedInUser = await authLocal.getUserId();

    debugPrint("Is the user recently logged in? $session");

    if (session != null && loggedInUser != null) {
      return true;
    }

    await authLocal.clearSession();
    return false;
  }
}
