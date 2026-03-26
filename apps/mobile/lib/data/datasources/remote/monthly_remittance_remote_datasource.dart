import 'package:dio/dio.dart';
import 'package:life_insurance_monitoring_mobile/core/constants/api_endpoints.dart';
import 'package:life_insurance_monitoring_mobile/data/models/monthly_remittance_request_model.dart';

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
    // TODO: this function must be rewritten to return either the result, or an error.
    try{
      final result = await dio.post(ApiEndpoints.calculateMonthlyRemittance, data: {
      });

      if(result.statusCode == 200) {
        final stringData = await result.data;

        return stringData['amountRemitted'].toDouble();
      }else{
        return 0;
      }
    } on DioException catch (e, stackTrace) {
      throw Exception('An Error occured while sending this request: $e. Stack Trace: \n\n $stackTrace');
    } finally {
      dio.close();
    }
  }

  @override
  Future<MonthlyRemittanceRequestModel> getAllCalculatedRemittanceHistory(String userId) async{
    // TODO: implement getAllCalculatedRemittanceHistory
    throw UnimplementedError();
  }
}