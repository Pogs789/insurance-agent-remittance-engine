enum PlanholderStatus {
  active,
  inactive,
  pastDue;

  String get apiValue {
    switch (this) {
      case PlanholderStatus.active:
        return 'Active';
      case PlanholderStatus.inactive:
        return 'Inactive';
      case PlanholderStatus.pastDue:
        return 'PastDue';
    }
  }

  static PlanholderStatus fromApi(String value) {
    switch (value) {
      case 'Active':
        return PlanholderStatus.active;
      case 'Inactive':
        return PlanholderStatus.inactive;
      case 'Past Due':
        return PlanholderStatus.pastDue;
      default:
        throw ArgumentError('Invalid PlanholderStatus: $value');
    }
  }
}

enum PaymentPeriod {
  monthly,
  quarterly,
  semiannually,
  annually,
  spotOn;

  String get apiValue {
    switch (this) {
      case PaymentPeriod.monthly:
        return 'Monthly';
      case PaymentPeriod.quarterly:
        return 'Quarterly';
      case PaymentPeriod.semiannually:
        return 'Semi-Annually';
      case PaymentPeriod.annually:
        return 'Annually';
      case PaymentPeriod.spotOn:
        return 'Spot-On';
    }
  }

  static PaymentPeriod fromApi(String value) {
    switch (value) {
      case 'Monthly':
        return PaymentPeriod.monthly;
      case 'Quarterly':
        return PaymentPeriod.quarterly;
      case 'SemiAnnually':
        return PaymentPeriod.semiannually;
      case 'Annually':
        return PaymentPeriod.annually;
      case 'SpotOn':
        return PaymentPeriod.spotOn;
      default:
        throw ArgumentError('Invalid PaymentPeriod: $value');
    }
  }
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
      'paymentPeriod': paymentPeriod.apiValue,
      'paymentPeriodAmount': paymentPeriodAmount,
      'planholderStatus': planholderStatus.apiValue,
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