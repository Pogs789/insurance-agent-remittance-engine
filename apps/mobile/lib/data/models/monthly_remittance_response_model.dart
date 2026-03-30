class RemittanceCalculationResponseModel {
  final double amountToBeRemitted;

  const RemittanceCalculationResponseModel({
    required this.amountToBeRemitted
  });

  factory RemittanceCalculationResponseModel.fromJson(Map<String, dynamic> json) {
    return RemittanceCalculationResponseModel(amountToBeRemitted: double.parse(json['amountToBeRemitted']));
  }
}