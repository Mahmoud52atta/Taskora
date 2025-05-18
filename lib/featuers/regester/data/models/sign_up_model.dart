import 'package:to_do_app/core/api/end_point.dart';
import 'package:to_do_app/featuers/regester/domain/entities/sign_up_entity.dart';

class SignUpModel extends SignupEntity {
  String? id;
  String? displayName;
  String? accessToken;
  String? refreshToken;

  SignUpModel({
    this.id,
    this.displayName,
    this.accessToken,
    this.refreshToken,
    required super.name,
    required super.phoneNumber,
    required super.experienceYear,
    required super.experienceLevel,
    required super.address,
    required super.password,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        id: json[ApiKey.id] ?? '',
        displayName: json[ApiKey.displyName] ?? '',
        accessToken: json[ApiKey.accessToken] ?? '',
        refreshToken: json[ApiKey.refreshToken] ?? '',
        name: json[ApiKey.displyName] ?? '',
        phoneNumber: json[ApiKey.phoneNumber] ?? '',
        experienceYear: json[ApiKey.experinceYear] ?? '',
        experienceLevel: json[ApiKey.expericneLevel] ?? '',
        address: json[ApiKey.address] ?? '',
        password: json[ApiKey.password] ?? '',
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'displayName': displayName,
        'access_token': accessToken,
        'refresh_token': refreshToken,
      };
}
