import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/core/api/dio_consumer.dart';
import 'package:to_do_app/featuers/regester/data/data_source/refresh_token_data_source.dart';
import 'package:to_do_app/featuers/home/data/data_sources/home_remote_data_source.dart';
import 'package:to_do_app/featuers/home/data/repos_impl/home_repo_impl.dart';
import 'package:to_do_app/featuers/regester/data/data_source/auth_remote_data_source.dart';
import 'package:to_do_app/featuers/regester/data/repo/auth_repo_imp.dart';

final getIt = GetIt.instance;

void setupServiceLocator(SharedPreferences sharedPreferences) {
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  final dio = Dio();

  // Create initial DioConsumer
  final initialDioConsumer = DioConsumer(dio: dio);
  getIt.registerSingleton<DioConsumer>(initialDioConsumer);

  // Create RefreshTokenDataSource with the initial DioConsumer
  getIt.registerSingleton<RefreshTokenDataSource>(
    RefreshTokenDataSource(apiConsumer: initialDioConsumer),
  );

  // Update the DioConsumer instance with RefreshTokenDataSource
  getIt.unregister<DioConsumer>();
  getIt.registerSingleton<DioConsumer>(
    DioConsumer(
      dio: dio,
      refreshTokenDataSource: getIt.get<RefreshTokenDataSource>(),
    ),
  );

  getIt.registerSingleton<AuthRemoteDataSource>(
    AuthRemoteDataSource(apiConsumer: getIt.get<DioConsumer>()),
  );

  getIt.registerSingleton<AuthRepoImp>(
    AuthRepoImp(authRemoteDataSource: getIt.get<AuthRemoteDataSource>()),
  );

  getIt.registerSingleton<HomeRemoteDataSource>(
    HomeRemoteDataSource(apiConsumer: getIt.get<DioConsumer>()),
  );

  getIt.registerSingleton<HomeRepoImpl>(
    HomeRepoImpl(homeRemoteDataSource: getIt.get<HomeRemoteDataSource>()),
  );
}
