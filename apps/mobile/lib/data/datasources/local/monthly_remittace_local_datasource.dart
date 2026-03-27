import '../../models/monthly_remittance_request_model.dart';

///This is where the calculations should be made if the app is offline.
abstract class MonthlyRemittanceLocalDataSource {
  Future<Map<String, dynamic>> calculateRemittanceAmountOffline(RemittanceCalculationRequestModel monthlyRemittance);
}

class MonthlyRemittanceLocalDataSourceImpl implements MonthlyRemittanceLocalDataSource {
  @override
  Future<Map<String, dynamic>> calculateRemittanceAmountOffline(RemittanceCalculationRequestModel monthlyRemittance) {
    // TODO: implement calculateRemittanceAmountOffline
    throw UnimplementedError();
  }
}