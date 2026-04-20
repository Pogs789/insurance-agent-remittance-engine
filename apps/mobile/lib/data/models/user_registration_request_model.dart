import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:life_insurance_monitoring_mobile/domain/entities/user.dart';

class UserRegistrationRequestModel {
  final String firstName;
  final String middleName;
  final String lastName;
  final DateTime birthDate;
  final String insuranceCompany;
  final String branchAddress;
  final double commissionRate;
  final String email;
  final String rawPassword;

  UserRegistrationRequestModel({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.birthDate,
    required this.insuranceCompany,
    required this.branchAddress,
    required this.commissionRate,
    required this.email,
    required this.rawPassword
  });

  Map<String, dynamic> toJson() =>
      {
        'firstName': firstName,
        'lastName': lastName,
        'middleName': middleName,
        'birthDate': DateFormat('MM-dd-yyyy').format(birthDate),
        'email': email,
        'password': rawPassword,
        'insuranceCompany': insuranceCompany,
        'branchAddress': branchAddress,
        'commissionRate': commissionRate
      };

  factory UserRegistrationRequestModel.fromJson(Map<String, dynamic> json) {
    return UserRegistrationRequestModel(
      firstName: json['firstName'] as String,
      middleName: json['middleName'] as String,
      lastName: json['lastName'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
      insuranceCompany: json['insuranceCompany'] as String,
      branchAddress: json['branchAddress'] as String,
      commissionRate: (json['commissionRate'] as num).toDouble(),
      email: json['email'] as String,
      rawPassword: json['rawPassword'] as String,
    );
  }

  factory UserRegistrationRequestModel.fromEntity(UserEntity e) {
    return UserRegistrationRequestModel(
      firstName: e.firstName,
      middleName: e.middleName,
      lastName: e.lastName,
      birthDate: e.birthDate,
      insuranceCompany: e.insuranceCompany,
      branchAddress: e.branchAddress,
      commissionRate: e.commissionRate,
      email: e.email,
      rawPassword: e.rawPassword,
    );
  }

  String toJsonString() => jsonEncode(toJson());
}