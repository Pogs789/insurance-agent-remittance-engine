import 'package:flutter/material.dart';
import 'package:life_insurance_monitoring_mobile/domain/entities/company.dart';
import 'package:life_insurance_monitoring_mobile/domain/usecases/company/company_usecase.dart';
import 'package:life_insurance_monitoring_mobile/core/errors/exceptions.dart';

class CompanyProvider extends ChangeNotifier {
  CompanyProvider(this._getCompanyUseCase);
  final GetCompanyUseCase _getCompanyUseCase;

  bool isLoading = false;
  String? errorMessage;
  bool isSuccess = false;
  double amountToBeRemitted = 0.0;

  Future<List<CompanyModel>> getAllCompanyNamesAndCommissionRates() async {
    isLoading = true;
    errorMessage = null;
    isSuccess = false;
    notifyListeners();

    try {
      final result = await _getCompanyUseCase();
      isSuccess = true;

      return result
          .map(
            (company) => CompanyModel(
              id: company.id,
              companyName: company.companyName,
              commissionRate: company.commissionRate,
            ),
          )
          .toList();
    } catch (e) {
      debugPrint('Error in CompanyProvider: $e');
      errorMessage = e is AppException ? e.message : e.toString();
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}