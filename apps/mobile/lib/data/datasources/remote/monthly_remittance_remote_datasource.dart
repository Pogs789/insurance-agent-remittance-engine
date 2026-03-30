import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:life_insurance_monitoring_mobile/core/constants/api_endpoints.dart';
import 'package:life_insurance_monitoring_mobile/core/errors/exceptions.dart';
import 'package:life_insurance_monitoring_mobile/data/models/monthly_remittance_request_model.dart';
import 'package:life_insurance_monitoring_mobile/data/models/monthly_remittance_response_model.dart';

abstract class MonthlyRemittanceRemoteDataSource {
  Future<RemittanceCalculationRequestModel> getAllCalculatedRemittanceHistory(String userId);
  Future<RemittanceCalculationResponseModel> calculateRemittanceAmount(RemittanceCalculationRequestModel monthlyRemittance, String? userId);
}

class MonthlyRemittanceRemoteDataSourceImpl implements MonthlyRemittanceRemoteDataSource {
  MonthlyRemittanceRemoteDataSourceImpl({
    required this.dio
  });
  
  final Dio dio;

  @override
  Future<RemittanceCalculationResponseModel> calculateRemittanceAmount(RemittanceCalculationRequestModel monthlyRemittance, String? userId) async{
    final payload = <String, dynamic>{
      ...monthlyRemittance.toJson(),
      'userId': userId
    };
    try{
      final result = await dio.post(
        ApiEndpoints.calculateMonthlyRemittance,
        data: payload,
        options: Options(
          contentType: Headers.jsonContentType
        )
      );

      if(result.statusCode == 200) {
        return RemittanceCalculationResponseModel.fromJson(result.data as Map<String, dynamic>);
      }

      throw Exception('An Error Occurred While Sending the Request: \n\n Status Code: ${result.statusCode} \n\n Error Message: ${result.statusMessage}');
    }catch (e, stackTrace) {
      throw Exception('An Error occurred: $e. \n\n Stack Trace: $stackTrace');
    }
  }

  @override
  Future<RemittanceCalculationRequestModel> getAllCalculatedRemittanceHistory(String userId) async{
    // TODO: implement getAllCalculatedRemittanceHistory
    throw UnimplementedError();
  }
}