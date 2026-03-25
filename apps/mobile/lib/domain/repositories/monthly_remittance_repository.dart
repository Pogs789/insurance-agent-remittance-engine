import 'package:life_insurance_monitoring_mobile/domain/entities/monthly_remittance.dart';

abstract class MonthlyRemittanceRepository {
  Future<void> submitMonthlyRemittance(MonthlyRemittance remittance);
}