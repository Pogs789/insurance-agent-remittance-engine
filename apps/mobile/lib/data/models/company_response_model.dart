class CompanyResponseModel {
  final String id;
  final String companyName;
  final double commissionRate;

  CompanyResponseModel({
    required this.id,
    required this.companyName,
    required this.commissionRate
  });

  factory CompanyResponseModel.fromJson(Map<String, dynamic> json) {
    final rawRate = json['commissionRate'];

    return CompanyResponseModel(
      id: json['id'] as String,
      companyName: json['companyName'] as String,
      commissionRate: double.tryParse(rawRate.toString()) ?? 0.0,
    );
  }

  static List<CompanyResponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map(
          (item) => CompanyResponseModel.fromJson(item as Map<String, dynamic>),
        )
        .toList();
  }
}