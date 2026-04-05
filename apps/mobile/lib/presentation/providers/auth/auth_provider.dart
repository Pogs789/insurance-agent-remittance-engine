import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;
  bool isSuccess = false;

  Future<void> authSubmit()
}