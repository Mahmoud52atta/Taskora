import 'package:dartz/dartz.dart';
import 'package:to_do_app/core/errors/service_errore.dart';
import 'package:to_do_app/featuers/regester/domain/entities/login_entity.dart';
import 'package:to_do_app/featuers/regester/domain/entities/sign_up_entity.dart';

abstract class AuthRepo {
  Future<Either<ServerException, LoginEntity>> login(
      {required String phone, required String password});
  Future<Either<ServerException, SignupEntity>> register({
    required String name,
    required String phoneNumber,
    required String experienceYear,
    required String experienceLevel,
    required String address,
    required String password,
  });

  //<>>
}
