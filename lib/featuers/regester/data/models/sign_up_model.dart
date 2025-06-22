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

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    // Add null safety check
    if (json == null) {
      throw Exception('Response data is null');
    }

    return SignUpModel(
      id: json[ApiKey.id]?.toString() ?? '',
      displayName: json[ApiKey.displyName]?.toString() ?? '',
      accessToken: json[ApiKey.accessToken]?.toString() ?? '',
      refreshToken: json[ApiKey.refreshToken]?.toString() ?? '',
      name: json[ApiKey.displyName]?.toString() ?? '',
      phoneNumber: json[ApiKey.phoneNumber]?.toString() ?? '',
      experienceYear: json[ApiKey.experinceYear]?.toString() ?? '',
      experienceLevel: json[ApiKey.expericneLevel]?.toString() ?? '',
      address: json[ApiKey.address]?.toString() ?? '',
      password: json[ApiKey.password]?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        ApiKey.id: id,
        ApiKey.displyName: displayName,
        ApiKey.accessToken: accessToken,
        ApiKey.refreshToken: refreshToken,
      };
}
