import 'package:life_insurance_monitoring_mobile/data/datasources/local/auth_local_datasource.dart';
import 'package:life_insurance_monitoring_mobile/data/models/auth_response_model.dart';
import 'package:life_insurance_monitoring_mobile/domain/entities/user.dart';

import 'package:life_insurance_monitoring_mobile/domain/repositories/auth_repository.dart';

import '../datasources/remote/auth_remote_datasource.dart';
import '../models/user_registration_request_model.dart';

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

    if(userId == null || refreshToken == null){
      await authLocal.clearSession();
    }

    await authRemote.logout(userId!, refreshToken!);
  }

  @override
  Future<void> refreshToken() async {
    final String? userId = await authLocal.getUserId();
    final String? refreshToken = await authLocal.getRefreshToken();

    if(userId == null || refreshToken == null){
      await authLocal.clearSession();
    }

    await authRemote.refreshToken(userId!, refreshToken!);
  }
}
