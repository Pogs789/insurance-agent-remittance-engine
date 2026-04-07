import 'package:life_insurance_monitoring_mobile/data/datasources/remote/auth_remote_datasource.dart';
import 'package:life_insurance_monitoring_mobile/data/models/user_registration_request_model.dart';
import 'package:life_insurance_monitoring_mobile/domain/entities/user.dart';
import 'package:life_insurance_monitoring_mobile/domain/repositories/agent_repository.dart';

class AgentRepositoryImpl implements AgentRepository {
  final AuthRemoteDataSource authRemote;
  AgentRepositoryImpl(this.authRemote);

  @override
  Future<Map<String, dynamic>> registerUser(UserEntity newUser) async {
    final req = UserRegistrationRequestModel.fromEntity(newUser);
    final response = await authRemote.registerUser(req);
    return response;
  }

  @override
  Future<Map<String, dynamic>> loginUser() {
    // TODO: implement loginUser
    throw UnimplementedError();
  }

}