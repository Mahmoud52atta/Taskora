import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/core/api/dio_consumer.dart';
import 'package:to_do_app/featuers/regester/data/data_source/auth_remote_data_source.dart';
import 'package:to_do_app/featuers/regester/data/repo/auth_repo_imp.dart';

final getIt = GetIt.instance;

void setupServiceLocator(SharedPreferences sharedPreferences) {
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  getIt.registerSingleton<DioConsumer>(
    DioConsumer(
      dio: Dio(),
    ),
  );

  getIt.registerSingleton<AuthRemoteDataSource>(
    AuthRemoteDataSource(apiConsumer: getIt.get<DioConsumer>()),
  );

  getIt.registerSingleton<AuthRepoImp>(
    AuthRepoImp(authRemoteDataSource: getIt.get<AuthRemoteDataSource>()),
  );
}
