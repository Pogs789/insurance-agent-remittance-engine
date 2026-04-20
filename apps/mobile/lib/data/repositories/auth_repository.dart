import 'package:life_insurance_monitoring_mobile/data/models/auth_response_model.dart';
import 'package:life_insurance_monitoring_mobile/domain/entities/user.dart';

import 'package:life_insurance_monitoring_mobile/domain/repositories/auth_repository.dart';

import '../datasources/remote/auth_remote_datasource.dart';
import '../models/user_registration_request_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemote;
  AuthRepositoryImpl(this.authRemote);

  @override
  Future<AuthSessionModel> loginUser(UserEntity user) async {
    // TODO: implement loginUser
    final req = UserRegistrationRequestModel.fromEntity(user);
    final response = await authRemote.login(
      req.email,
      req.rawPassword
    );
    return response;
  }

  @override
  Future<void> logout() async {
    await authRemote.logout();
  }

  @override
  Future<void> refreshToken() async {
    await authRemote.refreshToken();
  }
}