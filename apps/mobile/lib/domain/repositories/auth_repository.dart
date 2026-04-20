import 'package:life_insurance_monitoring_mobile/data/models/auth_response_model.dart';
import 'package:life_insurance_monitoring_mobile/domain/entities/user.dart';

abstract class AuthRepository {
  Future<AuthSessionModel> loginUser(UserEntity user);
  Future<void> refreshToken();
  Future<void> logout();
}