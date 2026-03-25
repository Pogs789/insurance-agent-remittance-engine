import 'package:life_insurance_monitoring_mobile/domain/entities/planholders.dart';

class MonthlyRemittance {
  final double commissionRate;
  final double amountRemitted; // calculated by backend
  final List<PlanholderData> planholderData;

  MonthlyRemittance({
    required this.commissionRate,
    this.amountRemitted = 0.0,
    required this.planholderData,
  });
}