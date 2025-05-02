import 'package:dio/dio.dart';
import 'package:to_do_app/core/api/end_point.dart';
import 'package:to_do_app/core/cash/cash_helper.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String? userId = CacheHelper.getDataString(key: ApiKey.id);
    String? refreshToken = CacheHelper.getDataString(key: ApiKey.refreshToken);
    String? accessToken = CacheHelper.getDataString(key: ApiKey.accessToken);

    if (refreshToken != null && refreshToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $refreshToken';
    }

    if (userId.isNotEmpty) {
      options.headers[ApiKey.id] = userId;
    }

    super.onRequest(options, handler);
  }
}