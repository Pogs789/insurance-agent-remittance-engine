import 'package:life_insurance_monitoring_mobile/data/models/auth_response_model.dart';
import 'package:life_insurance_monitoring_mobile/domain/entities/user.dart';
import 'package:life_insurance_monitoring_mobile/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepository;
  LoginUseCase(this.authRepository);

  Future<AuthSessionModel> call(UserEntity user) async {
    return await authRepository.loginUser(user);
  }
}

class RefreshTokenUseCase {
  final AuthRepository authRepository;
  RefreshTokenUseCase(this.authRepository);

  Future<void> call() async {
    authRepository.refreshToken();
  }
}

class LogoutUseCase {
  final AuthRepository authRepository;
  LogoutUseCase(this.authRepository);

  Future<void> call() async {
    return authRepository.logout();
  }
}
