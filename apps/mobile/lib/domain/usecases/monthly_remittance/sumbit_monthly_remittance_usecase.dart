import 'package:life_insurance_monitoring_mobile/domain/repositories/monthly_remittance_repository.dart';

import 'package:life_insurance_monitoring_mobile/domain/entities/monthly_remittance.dart';

class SubmitMonthlyRemittanceUseCase {
  final MonthlyRemittanceRepository repository;

  SubmitMonthlyRemittanceUseCase(this.repository);

  Future<void> call(MonthlyRemittance remittance) {
    return repository.submitMonthlyRemittance(remittance);
  }
}
