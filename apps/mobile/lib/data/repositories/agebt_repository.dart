import 'package:life_insurance_monitoring_mobile/data/datasources/remote/auth_remote_datasource.dart';
import 'package:life_insurance_monitoring_mobile/domain/repositories/agent_repository.dart';

class AgentRepositoryImpl implements AgentRepository {
  final AuthRemoteDataSource remote;
  AuthRemoteDataSourceImpl(this.remote);

  @override
  Future<Map<String, dynamic>> submitNewAgent()

}