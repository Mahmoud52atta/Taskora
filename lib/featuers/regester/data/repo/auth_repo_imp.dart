import 'package:dartz/dartz.dart';
import 'package:to_do_app/core/errors/service_errore.dart';
import 'package:to_do_app/featuers/regester/data/data_source/auth_remote_data_source.dart';
import 'package:to_do_app/featuers/regester/domain/entities/login_entity.dart';
import 'package:to_do_app/featuers/regester/domain/entities/profile_entity.dart';
import 'package:to_do_app/featuers/regester/domain/entities/sign_up_entity.dart';
import 'package:to_do_app/featuers/regester/domain/repos/auth_repo.dart';

class AuthRepoImp extends AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepoImp({required this.authRemoteDataSource});
  @override
  Future<Either<ServerException, LoginEntity>> login(
      {required String phone, required String password}) async {
    return await authRemoteDataSource.login(phone: phone, password: password);
  }

  @override
  Future<Either<ServerException, SignupEntity>> register(
      {required String name,
      required String phoneNumber,
      required String experienceYear,
      required String experienceLevel,
      required String address,
      required String password}) async {
    return await authRemoteDataSource.register(
        name: name,
        phoneNumber: phoneNumber,
        experienceYear: experienceYear,
        experienceLevel: experienceLevel,
        address: address,
        password: password);
  }

  @override
  Future<Either<ServerException, ProfileEntity>> getProfile() async {
    return await authRemoteDataSource.getProfile();
  }

  @override
  Future<Either<ServerException, void>> getRefreshToken(
      {required String accessToken}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<ServerException, void>> logout(
      {required String refreshToken}) async {
    return await authRemoteDataSource.logout(refreshToken: refreshToken);
  }
}
