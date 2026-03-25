import 'package:life_insurance_monitoring_mobile/data/datasources/remote/monthly_remittance_remote_datasource.dart';
import 'package:life_insurance_monitoring_mobile/data/models/monthly_remittance_request_model.dart';
import 'package:life_insurance_monitoring_mobile/domain/entities/monthly_remittance.dart';
import 'package:life_insurance_monitoring_mobile/domain/repositories/monthly_remittance_repository.dart';

class MonthlyRemittanceRepositoryImpl implements MonthlyRemittanceRepository {
  final MonthlyRemittanceRemoteDataSource remote;
  MonthlyRemittanceRepositoryImpl(this.remote);

  @override
  Future<void> submitMonthlyRemittance(MonthlyRemittance remittance) async {
    final req = MonthlyRemittanceRequestModel.fromEntity(remittance);
    await remote.calculateRemittanceAmount(req, userId);
  }
}