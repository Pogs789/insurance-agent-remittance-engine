import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:life_insurance_monitoring_mobile/core/constants/storage_constants.dart';
import 'package:life_insurance_monitoring_mobile/data/models/auth_response_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveSession(AuthSessionModel session);
  Future<AuthSessionModel?> getSession();
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<List<String>> getFullNameAndCompany();
  Future<String?> getUserId();
  Future<bool> hasAccessToken();
  Future<bool> hasRefreshToken();
  Future<void> clearSession();
  Future<bool> isLoggedIn();
  Future<String?> getUserRole();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl({FlutterSecureStorage? secureStorage})
    : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _secureStorage;

  @override
  Future<void> saveSession(AuthSessionModel session) async {
    final sessionJson = jsonEncode(session.toJson());


    await _secureStorage.write(
      key: StorageConstants.sessionKey,
      value: sessionJson,
    );
  }

  @override
  Future<AuthSessionModel?> getSession() async {
    final raw = await _secureStorage.read(key: StorageConstants.sessionKey);
    if (raw == null || raw.isEmpty) {
      return null;
    }

    try {
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      final userId = decoded['userId'] as String;
      return AuthSessionModel.fromJsonTokensOnly(decoded, userId);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<String?> getAccessToken() async {
    final session = await getSession();
    return session?.accessToken;
  }

  @override
  Future<String?> getRefreshToken() async {
    final session = await getSession();
    return session?.refreshToken;
  }

  @override
  Future<String?> getUserId() async {
    final session = await getSession();
    final userId = session?.userId;
    if (userId == null) return null;

    final trimmed = userId.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  @override
  Future<bool> hasAccessToken() async {
    final token = await getAccessToken();
    return token != null && token.trim().isNotEmpty;
  }

  @override
  Future<bool> hasRefreshToken() async {
    final token = await getRefreshToken();
    return token != null && token.trim().isNotEmpty;
  }

  @override
  Future<void> clearSession() async {
    await _secureStorage.delete(key: StorageConstants.sessionKey);
  }

  @override
  Future<bool> isLoggedIn() async {
    final userId = await getUserId();
    final hasToken = await hasAccessToken();
    return userId != null && hasToken;
  }

  //TODO: Needs Bug Fox on Insurance Information.
  @override
  Future<List<String>> getFullNameAndCompany() async {
    final companyInformation = await getSession();
    final String? fullName = companyInformation?.fullName;
    final String? insuranceCompany = companyInformation?.insuranceCompany;
    final String? companyId = companyInformation?.companyId;

    if(fullName == null || insuranceCompany == null || companyId == null) {
      await clearSession();
      return [];
    }

    return [fullName, insuranceCompany, companyId];
  }

  @override
  Future<String?> getUserRole() async {
    final userSession = await getSession();
    return userSession?.userRole;
  }
}
