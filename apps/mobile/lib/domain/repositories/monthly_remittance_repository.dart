import 'package:life_insurance_monitoring_mobile/data/models/monthly_remittance_response_model.dart';
import 'package:life_insurance_monitoring_mobile/domain/entities/monthly_remittance.dart';

abstract class MonthlyRemittanceRepository {
  Future<RemittanceCalculationResponseModel> submitMonthlyRemittance(MonthlyRemittance remittance);
}