enum Role { agent, companyAdmin, superAdmin }

class UserEntity {
  final String firstName;
  final String middleName;
  final String lastName;
  final DateTime birthDate;
  final String companyId;
  final String email;
  final String rawPassword;

  UserEntity({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.birthDate,
    required this.companyId,
    required this.email,
    required this.rawPassword,
  });
}
