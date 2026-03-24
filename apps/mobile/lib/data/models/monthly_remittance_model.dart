import 'dart:convert';

import 'package:life_insurance_monitoring_mobile/data/models/planholder_data_model.dart';

class MonthlyRemittanceModel {
  final double commissionRate;
  final double amountRemitted; // calculated by backend
  final List<PlanholderData> planholderData;

  MonthlyRemittanceModel({
    required this.commissionRate,
    this.amountRemitted = 0.0,
    required this.planholderData,
  });

  Map<String, dynamic> toJson() {
    return {
      'commissionRate': commissionRate,
      'amountRemitted': amountRemitted,
      'planholderData': planholderData.map((p) => p.toJson()).toList(),
    };
  }

  factory MonthlyRemittanceModel.fromJson(Map<String, dynamic> json) {
    return MonthlyRemittanceModel(
      commissionRate: (json['commissionRate'] as num).toDouble(),
      amountRemitted: (json['amountRemitted'] as num).toDouble(),
      planholderData: (json['planholderData'] as List)
          .map((item) => PlanholderData.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  String toJsonString() => jsonEncode(toJson());
}