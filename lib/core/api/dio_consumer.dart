import 'package:dio/dio.dart';
import 'package:to_do_app/core/api/api_consumer.dart';
import 'package:to_do_app/core/api/api_interceptor.dart';
import 'package:to_do_app/core/api/end_point.dart';
import 'package:to_do_app/core/errors/service_errore.dart';
import 'package:to_do_app/featuers/regester/data/data_source/refresh_token_data_source.dart';
// تأكد من تهيئة CacheHelper قبل استخدامه
// مهم جدًا قبل الاستخدام

Dio dio = Dio();

class DioConsumer extends ApiConsumer {
  final Dio dio;
  final RefreshTokenDataSource? refreshTokenDataSource;

  DioConsumer({
    required this.dio,
    this.refreshTokenDataSource,
  }) {
    dio.options.baseUrl = EndPoint.baseUrl;
    if (refreshTokenDataSource != null) {
      dio.interceptors.add(ApiInterceptor(
        refreshTokenDataSource: refreshTokenDataSource!,
        dio: dio,
      ));
    }
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }

  @override
  Future<dynamic> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(
        path,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future<dynamic> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    try {
      final response = await dio.patch(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future<dynamic> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    try {
      final response = await dio.put(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future<dynamic> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }
}
