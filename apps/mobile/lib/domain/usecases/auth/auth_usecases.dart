import 'package:life_insurance_monitoring_mobile/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepository;
  LoginUseCase(this.authRepository);

  Future<void> call(String email, String password) async {
    await authRepository.loginUser(email, password);
  }
}

class RefreshTokenUseCase {
  final AuthRepository authRepository;
  RefreshTokenUseCase(this.authRepository);

  Future<void> call() async {
    await authRepository.refreshToken();
  }
}

class LogoutUseCase {
  final AuthRepository authRepository;
  LogoutUseCase(this.authRepository);

  Future<void> call() async {
    return authRepository.logout();
  }
}

class IsLoggedInUseCase {
  final AuthRepository authRepository;
  IsLoggedInUseCase(this.authRepository);

  Future<bool> call() async {
    return authRepository.checkLoggedInUser();
  }
}