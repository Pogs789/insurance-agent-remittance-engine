import 'package:life_insurance_monitoring_mobile/domain/entities/user.dart';
import 'package:life_insurance_monitoring_mobile/domain/repositories/agent_repository.dart';

class AgentUseCase {
  final AgentRepository agentRepository;
  AgentUseCase(this.agentRepository);

  Future<Map<String, dynamic>> call(UserEntity user) async {
    return await agentRepository.registerUser(user);
  }
}
