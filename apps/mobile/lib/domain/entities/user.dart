enum Role {
  agent,
  admin
}

class UserEntity {
  final String firstName;
  final String middleName;
  final String lastName;
  final DateTime birthDate;
  final String insuranceCompany;
  final String branchAddress;
  final double commissionRate;
  final String email;
  final String rawPassword;

  UserEntity({
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
}