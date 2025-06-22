import 'package:dio/dio.dart';
import 'package:to_do_app/core/errors/error_model.dart';

class ServerException implements Exception {
  final ErrorModel errModel;

  ServerException({required this.errModel});
}

void handleDioExceptions(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ServerException(
        errModel: ErrorModel.fromJson(
          e.response?.data ?? {'message': 'Connection timeout'},
        ),
      );
    case DioExceptionType.sendTimeout:
      throw ServerException(
        errModel: ErrorModel.fromJson(
          e.response?.data ?? {'message': 'Send timeout'},
        ),
      );
    case DioExceptionType.receiveTimeout:
      throw ServerException(
        errModel: ErrorModel.fromJson(
          e.response?.data ?? {'message': 'Receive timeout'},
        ),
      );
    case DioExceptionType.badCertificate:
      throw ServerException(
        errModel: ErrorModel.fromJson(
          e.response?.data ?? {'message': 'Bad certificate'},
        ),
      );
    case DioExceptionType.cancel:
      throw ServerException(
        errModel: ErrorModel.fromJson(
          e.response?.data ?? {'message': 'Request cancelled'},
        ),
      );
    case DioExceptionType.connectionError:
      throw ServerException(
        errModel: ErrorModel.fromJson(
          e.response?.data ??
              {'message': 'Connection error - No internet connection'},
        ),
      );
    case DioExceptionType.unknown:
      throw ServerException(
        errModel: ErrorModel.fromJson(
          e.response?.data ?? {'message': 'Unknown error occurred'},
        ),
      );
    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400: // Bad request
          throw ServerException(
            errModel: ErrorModel.fromJson(
              e.response?.data ?? {'message': 'Bad request'},
            ),
          );
        case 401: //unauthorized
          throw ServerException(
            errModel: ErrorModel.fromJson(
              e.response?.data ?? {'message': 'Unauthorized'},
            ),
          );
        case 403: //forbidden
          throw ServerException(
            errModel: ErrorModel.fromJson(
              e.response?.data ?? {'message': 'Forbidden'},
            ),
          );
        case 404: //not found
          throw ServerException(
            errModel: ErrorModel.fromJson(
              e.response?.data ?? {'message': 'Not found'},
            ),
          );
        case 409: //cofficient
          throw ServerException(
            errModel: ErrorModel.fromJson(
              e.response?.data ?? {'message': 'Conflict'},
            ),
          );
        case 422: //  Unprocessable Entity
          throw ServerException(
            errModel: ErrorModel.fromJson(
              e.response?.data ?? {'message': 'Unprocessable entity'},
            ),
          );
        case 504: // Server exception
          throw ServerException(
            errModel: ErrorModel.fromJson(
              e.response?.data ?? {'message': 'Server error'},
            ),
          );
        default:
          throw ServerException(
            errModel: ErrorModel.fromJson(
              e.response?.data ?? {'message': 'Server error occurred'},
            ),
          );
      }
  }
}
