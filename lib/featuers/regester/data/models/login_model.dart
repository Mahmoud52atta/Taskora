import 'package:to_do_app/core/api/end_point.dart';
import 'package:to_do_app/featuers/regester/domain/entities/login_entity.dart';

class LoginModel extends LoginEntity {
  final String accessToken;
  final String refreshToken;
  LoginModel(
      {required super.phone,
      required super.password,
      required super.id,
      required this.accessToken,
      required this.refreshToken});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
        phone: json[ApiKey.phoneNumber]??'',
        password: json[ApiKey.password]??'',
        id: json[ApiKey.id]??'',
        accessToken: json[ApiKey.accessToken]??'',
        refreshToken: json[ApiKey.refreshToken]??'');
  }
  
}
