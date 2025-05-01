import 'package:dartz/dartz.dart';
import 'package:to_do_app/core/errors/service_errore.dart';
import 'package:to_do_app/featuers/regester/data/data_source/remote_data_source.dart';
import 'package:to_do_app/featuers/regester/data/models/login_model.dart';
import 'package:to_do_app/featuers/regester/domain/entities/sign_up_entity.dart';
import 'package:to_do_app/featuers/regester/domain/repos/auth_repo.dart';

class AuthRopeImpl implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRopeImpl({required this.authRemoteDataSource});
  
  @override
  Future<Either<ServerException, LoginModel>> login({required String phone, required String password})async {
return await authRemoteDataSource.login(phone: phone, password: password);}
  
  @override
  Future<Either<ServerException, SignupEntity>> register({required String name, required String phoneNumber, required int experienceYear, required String experienceLevel, required String address, required String password}) {
    // TODO: implement register
    throw UnimplementedError();
  }

 
  
}
