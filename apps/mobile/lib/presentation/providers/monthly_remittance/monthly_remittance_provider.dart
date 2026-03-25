import 'package:flutter/foundation.dart';
import '../../../domain/entities/monthly_remittance.dart';
import '../../../domain/usecases/monthly_remittance/sumbit_monthly_remittance_usecase.dart';

class MonthlyRemittanceProvider extends ChangeNotifier {
  final SubmitMonthlyRemittanceUseCase submitUseCase;
  MonthlyRemittanceProvider(this.submitUseCase);

  bool isLoading = false;
  String? errorMessage;
  bool isSuccess = false;

  Future<void> submit(MonthlyRemittance remittance) async {
    isLoading = true;
    errorMessage = null;
    isSuccess = false;
    notifyListeners();

    try {
      await submitUseCase(remittance);
      isSuccess = true;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
