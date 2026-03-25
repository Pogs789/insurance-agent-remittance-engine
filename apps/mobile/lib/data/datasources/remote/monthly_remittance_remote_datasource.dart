import 'package:dio/dio.dart';
import 'package:life_insurance_monitoring_mobile/data/models/monthly_remittance_model.dart';

abstract class MonthlyRemittanceRemoteDataSource {
  Future<MonthlyRemittanceModel> getAllCalculatedRemittanceHistory(String userId);
  Future<double> calculateRemittanceAmount(MonthlyRemittanceModel monthlyRemittance, String userId);
}

class MonthlyRemittanceRemoteDataSourceImpl implements MonthlyRemittanceRemoteDataSource {
  MonthlyRemittanceRemoteDataSourceImpl({
    required this.dio
  });
  
  final Dio dio;

  @override
  Future<double> calculateRemittanceAmount(MonthlyRemittanceModel monthlyRemittance, String userId) {
    // TODO: implement calculateRemittanceAmount
    throw UnimplementedError();
  }

  @override
  Future<MonthlyRemittanceModel> getAllCalculatedRemittanceHistory(String userId) {
    // TODO: implement getAllCalculatedRemittanceHistory
    throw UnimplementedError();
  }
}