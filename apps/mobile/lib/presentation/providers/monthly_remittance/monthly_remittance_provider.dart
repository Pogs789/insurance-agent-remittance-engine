import 'package:flutter/foundation.dart';
import 'package:life_insurance_monitoring_mobile/core/errors/exceptions.dart';
import 'package:life_insurance_monitoring_mobile/domain/entities/monthly_remittance.dart';
import 'package:life_insurance_monitoring_mobile/domain/usecases/monthly_remittance/monthly_remittance_usecase.dart';

class MonthlyRemittanceProvider extends ChangeNotifier {
  MonthlyRemittanceProvider(this._submitUseCase);
  final MonthlyRemittanceUseCase _submitUseCase;

  bool isLoading = false;
  String? errorMessage;
  bool isSuccess = false;
  double amountToBeRemitted = 0.0;

  Future<void> submit(MonthlyRemittance remittance) async {
    isLoading = true;
    errorMessage = null;
    isSuccess = false;
    notifyListeners();

    try {
      final result = await _submitUseCase(remittance);
      amountToBeRemitted = result.amountToBeRemitted;
      isSuccess = true;
    } catch (e) {
      debugPrint('Error in MonthlyRemittanceProvider: $e');
      errorMessage = e is AppException ? e.message : e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
