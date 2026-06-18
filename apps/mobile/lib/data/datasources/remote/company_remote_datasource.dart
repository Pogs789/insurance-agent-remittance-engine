import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:life_insurance_monitoring_mobile/core/constants/api_endpoints.dart';
import 'package:life_insurance_monitoring_mobile/core/errors/exceptions.dart';
import 'package:life_insurance_monitoring_mobile/data/models/company_response_model.dart';

abstract class CompanyRemoteDataSource {
  Future<List<CompanyResponseModel>> getAllCompaniesAndCommissionRates();
}

class CompanyRemoteDataSourceImpl implements CompanyRemoteDataSource {
  CompanyRemoteDataSourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<List<CompanyResponseModel>> getAllCompaniesAndCommissionRates() async {
    try {
      debugPrint('Company URL: ${ApiEndpoints.getCompanyNamesAndCommissionRates}');
      final result = await dio.get(ApiEndpoints.getCompanyNamesAndCommissionRates);

      if (result.statusCode == 200) {
        return CompanyResponseModel.fromJsonList(result.data as List<dynamic>);
      }

      throw Exception(
        'An Error Occurred While Sending the Request: \n\n Status Code: ${result.statusCode} \n\n Error Message: ${result.statusMessage}',
      );
    }catch (e, stackTrace) {
      throw mapToAppException(e, stackTrace);
    }
  }

}