import 'dart:convert';

import 'package:life_insurance_monitoring_mobile/domain/entities/planholders.dart';

import 'package:life_insurance_monitoring_mobile/domain/entities/monthly_remittance.dart';

class RemittanceCalculationRequestModel {
  final double commissionRate;
  final double amountRemitted; // calculated by backend
  final List<PlanholderData> planholderData;

  RemittanceCalculationRequestModel({
    required this.commissionRate,
    this.amountRemitted = 0.0,
    required this.planholderData,
  });

  Map<String, dynamic> toJson() {
    return {
      'commissionRate': commissionRate,
      'planholderData': planholderData.map((p) => p.toJson()).toList(),
    };
  }

  factory RemittanceCalculationRequestModel.fromJson(Map<String, dynamic> json) {
    return RemittanceCalculationRequestModel(
      commissionRate: (json['commissionRate'] as num).toDouble(),
      amountRemitted: (json['amountRemitted'] as num).toDouble(),
      planholderData: (json['planholderData'] as List)
          .map((item) => PlanholderData.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  factory RemittanceCalculationRequestModel.fromEntity(MonthlyRemittance e) {
    return RemittanceCalculationRequestModel(
      commissionRate: e.commissionRate,
      amountRemitted: e.amountRemitted,
      planholderData: e.planholderData
    );
  }

  String toJsonString() => jsonEncode(toJson());
}