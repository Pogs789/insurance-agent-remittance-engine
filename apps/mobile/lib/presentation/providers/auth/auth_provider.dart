import 'package:flutter/material.dart';
import 'package:life_insurance_monitoring_mobile/core/errors/exceptions.dart';
import 'package:life_insurance_monitoring_mobile/data/models/auth_response_model.dart';
import 'package:life_insurance_monitoring_mobile/domain/usecases/auth/auth_usecases.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/usecases/agent/agent_usecase.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider(this._submitAgentUseCase, this._loginUseCase, this._refreshTokenUseCase, this._logoutUseCase);
  final AgentUseCase _submitAgentUseCase;
  final LoginUseCase _loginUseCase;
  final RefreshTokenUseCase _refreshTokenUseCase;
  final LogoutUseCase _logoutUseCase;

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

  Future<void> login(UserEntity user) async {
    isLoading = false;
    errorMessage = null;
    isSuccess = false;
    notifyListeners();

    try{
      final result = await _loginUseCase(user);
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

  Future<void> refreshToken() async {
    isLoading = false;
    errorMessage = null;
    isSuccess = false;
    notifyListeners();

    try{
      await _refreshTokenUseCase();
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

  Future<void> logout() async {
    isLoading = false;
    errorMessage = null;
    isSuccess = false;
    notifyListeners();

    try{
      await _logoutUseCase();
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