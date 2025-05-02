import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:to_do_app/core/api/api_consumer.dart';
import 'package:to_do_app/core/api/dio_consumer.dart';
import 'package:to_do_app/core/api/end_point.dart';
import 'package:to_do_app/core/cash/cash_helper.dart';
import 'package:to_do_app/core/errors/service_errore.dart';
import 'package:to_do_app/featuers/regester/data/models/log_in_model.dart';
import 'package:to_do_app/featuers/regester/data/models/sign_up_model.dart';
import 'package:to_do_app/featuers/regester/domain/entities/login_entity.dart';
import 'package:to_do_app/featuers/regester/domain/entities/sign_up_entity.dart';

class AuthRemoteDataSource {
  final ApiConsumer apiConsumer;

  AuthRemoteDataSource({
    required this.apiConsumer,
  });

  Future<Either<ServerException, LoginEntity>> login(
      {required String phone, required String password}) async {
    try {
      final responce = await apiConsumer.post(EndPoint.signIn,
          data: {ApiKey.phoneNumber: phone, ApiKey.password: password});
      final user = LogInModel.fromJson(responce);
      await CacheHelper.saveData(
          key: ApiKey.accessToken, value: user.accessToken);
      await CacheHelper.saveData(
          key: ApiKey.refreshToken, value: user.refreshToken);
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerException(errModel: e.errModel));
    }
  }

  Future<Either<ServerException, SignupEntity>> register({
    required String name,
    required String phoneNumber,
    required String experienceYear,
    required String experienceLevel,
    required String address,
    required String password,
  }) async {
    try {
      final responce = await apiConsumer.post(EndPoint.signUp, data: {
        ApiKey.displyName: name,
        ApiKey.phoneNumber: phoneNumber,
        ApiKey.experinceYear: experienceYear,
        ApiKey.expericneLevel: experienceLevel,
        ApiKey.address: address,
        ApiKey.password: password,
      });
      final user = SignUpModel.fromJson(responce);
      await CacheHelper.saveData(
          key: ApiKey.accessToken, value: user.accessToken);
      await CacheHelper.saveData(
          key: ApiKey.refreshToken, value: user.refreshToken);
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerException(errModel: e.errModel));
    }
  }
}
