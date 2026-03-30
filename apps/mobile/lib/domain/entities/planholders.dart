enum PlanholderStatus {
  ACTIVE,
  INACTIVE,
  PASTDUE
}

enum PaymentPeriod {
  monthly,
  quarterly,
  semiannually,
  annually,
}

class PlanholderData {
  String planholderName;
  String insuranceProduct;
  double insuranceAmount;
  PaymentPeriod paymentPeriod;
  double paymentPeriodAmount;
  PlanholderStatus planholderStatus;

  PlanholderData({
    required this.planholderName,
    this.insuranceProduct = '',
    this.insuranceAmount = 0.0,
    required this.paymentPeriod,
    required this.paymentPeriodAmount,
    required this.planholderStatus,
  });

  Map<String, dynamic> toJson() {
    return {
      'planholderName': planholderName,
      'insuranceProduct': insuranceProduct,
      'insuranceAmount': insuranceAmount,
      'paymentPeriod': paymentPeriod.name.toUpperCase(),
      'paymentPeriodAmount': paymentPeriodAmount,
      'planholderStatus': planholderStatus.name.toUpperCase(),
    };
  }

  factory PlanholderData.fromJson(Map<String, dynamic> json) {
    return PlanholderData(
      planholderName: json['planholderName'] as String,
      insuranceProduct: json['insuranceProduct'] as String,
      insuranceAmount: (json['insuranceAmount'] as num).toDouble(),
      paymentPeriod: PaymentPeriod.values.firstWhere(
            (e) => e.name == json['paymentPeriod'],
      ),
      paymentPeriodAmount: (json['paymentPeriodAmount'] as num).toDouble(),
      planholderStatus: PlanholderStatus.values.firstWhere(
            (e) => e.name == json['planholderStatus'],
      ),
    );
  }
}