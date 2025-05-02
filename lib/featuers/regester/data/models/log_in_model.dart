import 'package:to_do_app/core/api/end_point.dart';
import 'package:to_do_app/featuers/regester/domain/entities/login_entity.dart';

class LogInModel extends LoginEntity {
  String? id;
  String? accessToken;
  String? refreshToken;

  LogInModel(
      {this.id,
      this.accessToken,
      this.refreshToken,
      required super.phone,
      required super.password});

  factory LogInModel.fromJson(Map<String, dynamic> json) => LogInModel(
        id: json[ApiKey.id] ?? '',
        accessToken: json[ApiKey.accessToken] ?? '',
        refreshToken: json[ApiKey.refreshToken] ?? '',
        phone: json[ApiKey.phoneNumber] ?? '',
        password: json[ApiKey.password] ?? '',
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'access_token': accessToken,
        'refresh_token': refreshToken,
      };
}
