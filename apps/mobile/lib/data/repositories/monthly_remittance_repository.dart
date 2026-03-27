import 'package:life_insurance_monitoring_mobile/data/datasources/local/auth_local_datasource.dart';
import 'package:life_insurance_monitoring_mobile/data/datasources/remote/monthly_remittance_remote_datasource.dart';
import 'package:life_insurance_monitoring_mobile/data/models/monthly_remittance_request_model.dart';
import 'package:life_insurance_monitoring_mobile/data/models/monthly_remittance_response_model.dart';
import 'package:life_insurance_monitoring_mobile/domain/entities/monthly_remittance.dart';
import 'package:life_insurance_monitoring_mobile/domain/repositories/monthly_remittance_repository.dart';

class MonthlyRemittanceRepositoryImpl implements MonthlyRemittanceRepository {
  final MonthlyRemittanceRemoteDataSource remote;
  MonthlyRemittanceRepositoryImpl(this.remote);

  //TODO: Implement here offline-first capability where if theres no network connection, the calculation should be done within the mobile app.
  @override
  Future<RemittanceCalculationResponseModel> submitMonthlyRemittance(MonthlyRemittance remittance) async {
    final req = RemittanceCalculationRequestModel.fromEntity(remittance);
    final userId = await AuthLocalDataSourceImpl().getUserId();
    final response = await remote.calculateRemittanceAmount(req, userId);

    return RemittanceCalculationResponseModel(amountToBeRemitted: response.amountToBeRemitted);
  }
}