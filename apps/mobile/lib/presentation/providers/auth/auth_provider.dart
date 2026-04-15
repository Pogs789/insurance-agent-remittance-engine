import 'package:flutter/material.dart';
import 'package:life_insurance_monitoring_mobile/core/errors/exceptions.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/usecases/agent/agent_usecase.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider(this._submitAgentUseCase);
  final AgentUseCase _submitAgentUseCase;

  bool isLoading = false;
  String? errorMessage;
  bool isSuccess = false;

  Future<void> newAgentSubmit(UserEntity user) async {
    isLoading = false;
    errorMessage = null;
    isSuccess = false;
    notifyListeners();

    try{
      final result = await _submitAgentUseCase(user);
      isSuccess = result['success'];
    } on AppException catch (e) {
      errorMessage = e.message;
    } catch (_) {
      errorMessage = 'Something went wrong. Please try again.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> login() async {
    isLoading = false;
    errorMessage = null;
    isSuccess = false;
    notifyListeners();

    try{
      debugPrint('Hi from AuthProvider');
      debugPrint('useCase runtimeType: ${_submitAgentUseCase.runtimeType}');
      isSuccess = true;
    } on AppException catch (e) {
      errorMessage = e.message;
    } catch (_) {
      errorMessage = 'Something went wrong. Please try again.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}