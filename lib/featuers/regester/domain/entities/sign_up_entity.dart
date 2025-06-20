class SignupEntity {
  final String name;
  final String phoneNumber;
  final String experienceYear;
  final String experienceLevel;
  final String address;
  final String password;

  SignupEntity(
      {required this.name,
      required this.phoneNumber,
      required this.experienceYear,
      required this.experienceLevel,
      required this.address,
      required this.password});
}
