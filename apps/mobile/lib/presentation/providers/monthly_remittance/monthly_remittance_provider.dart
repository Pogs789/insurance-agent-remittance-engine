import 'package:flutter/foundation.dart';
import 'package:life_insurance_monitoring_mobile/domain/entities/monthly_remittance.dart';
import 'package:life_insurance_monitoring_mobile/domain/usecases/monthly_remittance/submit_monthly_remittance_usecase.dart';

class MonthlyRemittanceProvider extends ChangeNotifier {
  MonthlyRemittanceProvider(this._submitUseCase);
  final SubmitMonthlyRemittanceUseCase _submitUseCase;

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
      debugPrint('Hi from MonthlyRemittanceProvider');
      debugPrint('useCase runtimeType: ${_submitUseCase.runtimeType}');
      final result = await _submitUseCase(remittance);
      amountToBeRemitted = result.amountToBeRemitted;
      isSuccess = true;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
