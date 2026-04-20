import 'package:life_insurance_monitoring_mobile/domain/entities/user.dart';

abstract class AgentRepository {
  Future<Map<String, dynamic>> registerUser(UserEntity newUser);
}