import 'package:to_do_app/core/api/end_point.dart';
import 'package:to_do_app/featuers/regester/domain/entities/sign_up_entity.dart';

class SignUpModel extends SignupEntity {
  final String id;
  final String accessToken;
  final String refreshToken;

  SignUpModel(
      {required this.id,
      required this.accessToken,
      required this.refreshToken,
      required super.name,
      required super.phoneNumber,
      required super.experienceYear,
      required super.experienceLevel,
      required super.address,
      required super.password});
  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
        id: json[ApiKey.id]??'',
        accessToken: json[ApiKey.accessToken]??'',
        refreshToken: json[ApiKey.refreshToken]??'',
        name: json[ApiKey.name]??'',
        phoneNumber: json[ApiKey.phoneNumber]??'',
        experienceYear: json[ApiKey.experinceYear]??'',
        experienceLevel: json[ApiKey.expericneLevel]??'',
        address: json[ApiKey.address]??'',
        password: json[ApiKey.password]??'');
  }
}
