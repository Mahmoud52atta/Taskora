import 'package:dartz/dartz.dart';
import 'package:to_do_app/core/api/api_consumer.dart';
import 'package:to_do_app/core/api/end_point.dart';
import 'package:to_do_app/core/cash/cash_helper.dart';
import 'package:to_do_app/core/errors/service_errore.dart';

class RefreshTokenDataSource {
  final ApiConsumer apiConsumer;

  RefreshTokenDataSource({required this.apiConsumer});

  Future<Either<ServerException, String>> refreshToken() async {
    try {
      final refreshToken = CacheHelper.getDataString(key: ApiKey.refreshToken);
      final response = await apiConsumer.get(
        '${EndPoint.baseUrl}auth/refresh-token?token=$refreshToken',
      );
      final newAccessToken = response[ApiKey.accessToken];
      await CacheHelper.saveData(
          key: ApiKey.accessToken, value: newAccessToken);
      return Right(newAccessToken);
    } on ServerException catch (e) {
      return Left(ServerException(errModel: e.errModel));
    }
  }
}
