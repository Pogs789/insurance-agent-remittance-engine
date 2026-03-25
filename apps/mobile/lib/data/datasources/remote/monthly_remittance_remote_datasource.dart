import 'package:dio/dio.dart';
import 'package:life_insurance_monitoring_mobile/core/constants/api_endpoints.dart';
import 'package:life_insurance_monitoring_mobile/data/models/monthly_remittance_request_model.dart';
import 'package:life_insurance_monitoring_mobile/domain/entities/monthly_remittance.dart';

abstract class MonthlyRemittanceRemoteDataSource {
  Future<MonthlyRemittanceRequestModel> getAllCalculatedRemittanceHistory(String userId);
  Future<double> calculateRemittanceAmount(MonthlyRemittanceRequestModel monthlyRemittance, String userId);
}

class MonthlyRemittanceRemoteDataSourceImpl implements MonthlyRemittanceRemoteDataSource {
  MonthlyRemittanceRemoteDataSourceImpl({
    required this.dio
  });
  
  final Dio dio;

  @override
  Future<double> calculateRemittanceAmount(MonthlyRemittanceRequestModel monthlyRemittance, String userId) async{
    // TODO: implement calculateRemittanceAmount
    await dio.post(ApiEndpoints.calculateMonthlyRemittance, data: {
    });
    throw UnimplementedError();
  }

  @override
  Future<MonthlyRemittanceRequestModel> getAllCalculatedRemittanceHistory(String userId) async{
    // TODO: implement getAllCalculatedRemittanceHistory
    throw UnimplementedError();
  }
}