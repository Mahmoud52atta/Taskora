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
        id: json[ApiKey.id] as String?,
        displayName: json[ApiKey.displyName] as String?,
        accessToken: json[ApiKey.accessToken] as String?,
        refreshToken: json[ApiKey.refreshToken] as String?,
        name: json[ApiKey.displyName] as String,
        phoneNumber: json[ApiKey.phoneNumber]as String,
        experienceYear: json[ApiKey.experinceYear]as String,
        experienceLevel: json[ApiKey.expericneLevel]as String,
        address: json[ApiKey.address]as String,
        password: json[ApiKey.password]as String,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'displayName': displayName,
        'access_token': accessToken,
        'refresh_token': refreshToken,
      };
}
