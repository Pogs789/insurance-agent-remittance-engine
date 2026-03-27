import 'package:flutter/material.dart';
import 'package:life_insurance_monitoring_mobile/data/models/monthly_remittance_response_model.dart';
import 'package:life_insurance_monitoring_mobile/domain/repositories/monthly_remittance_repository.dart';

import 'package:life_insurance_monitoring_mobile/domain/entities/monthly_remittance.dart';

class SubmitMonthlyRemittanceUseCase {
  final MonthlyRemittanceRepository repository;

  SubmitMonthlyRemittanceUseCase(this.repository);

  Future<RemittanceCalculationResponseModel> call(MonthlyRemittance remittance) async {
    debugPrint('Hi from SubmitMonthlyRemittanceUseCase');
    return await repository.submitMonthlyRemittance(remittance);
  }
}
