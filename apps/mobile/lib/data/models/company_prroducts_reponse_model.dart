class CompanyProductsResponseModel {
  final String id;
  final String insuranceProductName;
  final String productContents;
  final double productAmount;
  final List<PaymentTerms> paymentTerms;

  CompanyProductsResponseModel({
    required this.id,
    required this.insuranceProductName,
    required this.productContents,
    required this.productAmount,
    required this.paymentTerms,
  });

  factory CompanyProductsResponseModel.fromJson(Map<String, dynamic> json) {
    return CompanyProductsResponseModel(
      id: json['id']?.toString() ?? '',
      insuranceProductName: json['insuranceProductName']?.toString() ?? '',
      productContents: json['productContents']?.toString() ?? '',
      productAmount: json['productAmount'] is num
          ? (json['productAmount'] as num).toDouble()
          : double.tryParse(json['productAmount']?.toString() ?? '0.0') ?? 0.0,
      // Fixed: Explicitly look up as a List first, then map cleanly
      paymentTerms: json['paymentTerms'] is List
          ? (json['paymentTerms'] as List)
          .map((item) => PaymentTerms.fromJson(item as Map<String, dynamic>))
          .toList()
          : [],
    );
  }

  static List<CompanyProductsResponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((item) => CompanyProductsResponseModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}

class PaymentTerms {
  final String period;
  final double amount;

  PaymentTerms({
    required this.period,
    required this.amount,
  });

  factory PaymentTerms.fromJson(Map<String, dynamic> json) {
    return PaymentTerms(
      period: json['period']?.toString() ?? '',
      amount: json['amount'] is num
          ? (json['amount'] as num).toDouble()
          : double.tryParse(json['amount']?.toString() ?? '0.0') ?? 0.0,
    );
  }
}
