import 'package:life_insurance_monitoring_mobile/data/models/user_registration_request_model.dart';

abstract class AgentRepository {
  Future<Map<String, dynamic>> registerUser(UserRegistrationRequestModel newUser);
}