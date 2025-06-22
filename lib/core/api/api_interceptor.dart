import 'package:dio/dio.dart';
import 'package:to_do_app/core/cash/cash_helper.dart';
import 'package:to_do_app/featuers/regester/data/data_source/refresh_token_data_source.dart';

class ApiInterceptor extends Interceptor {
  final RefreshTokenDataSource refreshTokenDataSource;
  final Dio dio;

  ApiInterceptor({
    required this.refreshTokenDataSource,
    required this.dio,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final accessToken = CacheHelper.getDataString(key: 'access_token');
    if (accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    super.onRequest(options, handler);
    CacheHelper.getDataString(key: '_id');
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    // Don't attempt token refresh for authentication endpoints
    final isAuthEndpoint = err.requestOptions.path.contains('auth/login') ||
        err.requestOptions.path.contains('auth/register') ||
        err.requestOptions.path.contains('auth/signin') ||
        err.requestOptions.path.contains('auth/signup');

    if (err.response?.statusCode == 401 && !isAuthEndpoint) {
      try {
        // Try to refresh the token
        final result = await refreshTokenDataSource.refreshToken();

        return result.fold(
          (failure) async {
            // If refresh fails, clear tokens and proceed with error
            await CacheHelper.removeData(key: 'access_token');
            await CacheHelper.removeData(key: 'refresh_token');
            return handler.reject(err);
          },
          (success) async {
            // If refresh succeeds, retry the original request
            final newAccessToken =
                CacheHelper.getDataString(key: 'access_token');
            if (newAccessToken.isNotEmpty) {
              err.requestOptions.headers['Authorization'] =
                  'Bearer $newAccessToken';
              try {
                // Retry the request
                final response = await dio.fetch(err.requestOptions);
                return handler.resolve(response);
              } catch (e) {
                return handler.reject(err);
              }
            }
            return handler.reject(err);
          },
        );
      } catch (e) {
        // If any error occurs during refresh, clear tokens and proceed with error
        await CacheHelper.removeData(key: 'access_token');
        await CacheHelper.removeData(key: 'refresh_token');
        return handler.reject(err);
      }
    } else {
      return handler.reject(err);
    }
  }
}
