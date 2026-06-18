import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:life_insurance_monitoring_mobile/domain/entities/user.dart';

class UserRegistrationRequestModel {
  final String firstName;
  final String middleName;
  final String lastName;
  final DateTime birthDate;
  final String insuranceCompanyId;
  final String email;
  final String rawPassword;

  UserRegistrationRequestModel({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.birthDate,
    required this.insuranceCompanyId,
    required this.email,
    required this.rawPassword,
  });

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'middleName': middleName,
    'birthDate': DateFormat('MM-dd-yyyy').format(birthDate),
    'email': email,
    'password': rawPassword,
    'insuranceCompanyId': insuranceCompanyId,
  };

  factory UserRegistrationRequestModel.fromEntity(UserEntity e) {
    return UserRegistrationRequestModel(
      firstName: e.firstName,
      middleName: e.middleName,
      lastName: e.lastName,
      birthDate: e.birthDate,
      insuranceCompanyId: e.companyId,
      email: e.email,
      rawPassword: e.rawPassword,
    );
  }

  String toJsonString() => jsonEncode(toJson());
}
