import 'package:dartz/dartz.dart';
import 'package:to_do_app/core/api/api_consumer.dart';
import 'package:to_do_app/core/api/end_point.dart';
import 'package:to_do_app/core/cash/cash_helper.dart';
import 'package:to_do_app/core/errors/service_errore.dart';
import 'package:to_do_app/core/errors/error_model.dart';
import 'package:to_do_app/featuers/regester/data/models/log_in_model.dart';
import 'package:to_do_app/featuers/regester/data/models/profile_model.dart';
import 'package:to_do_app/featuers/regester/data/models/sign_up_model.dart';
import 'package:to_do_app/featuers/regester/domain/entities/login_entity.dart';
import 'package:to_do_app/featuers/regester/domain/entities/profile_entity.dart';
import 'package:to_do_app/featuers/regester/domain/entities/sign_up_entity.dart';

class AuthRemoteDataSource {
  final ApiConsumer apiConsumer;

  AuthRemoteDataSource({
    required this.apiConsumer,
  });

  Future<Either<ServerException, LoginEntity>> login(
      {required String phone, required String password}) async {
    try {
      print('Attempting login with phone: $phone');

      // Validate phone number format
      if (phone.isEmpty) {
        return Left(ServerException(
          errModel: ErrorModel(errorMessage: 'Phone number is required.'),
        ));
      }

      // Remove any extra characters and ensure proper format
      String cleanPhone = phone.replaceAll(RegExp(r'[^\d+]'), '');
      if (!cleanPhone.startsWith('+')) {
        cleanPhone = '+$cleanPhone';
      }

      print('Cleaned phone number: $cleanPhone');

      final response = await apiConsumer.post(EndPoint.signIn,
          data: {ApiKey.phoneNumber: cleanPhone, ApiKey.password: password});
      final user = LogInModel.fromJson(response);
      await CacheHelper.saveData(
          key: ApiKey.accessToken, value: user.accessToken);
      print('Access Token: ${user.accessToken}');
      await CacheHelper.saveData(
          key: ApiKey.refreshToken, value: user.refreshToken);
      return Right(user);
    } on ServerException catch (e) {
      print('Login failed with error: ${e.errModel.errorMessage}');

      // Handle specific error cases for login
      String userFriendlyMessage = e.errModel.errorMessage;

      // Check for Arabic error messages and provide English translations
      if (e.errModel.errorMessage
          .contains('يوجد خطأ في رقم الهاتف أو كلمة المرور')) {
        userFriendlyMessage =
            'Invalid phone number or password. Please check your credentials and try again.';
      } else if (e.errModel.errorMessage.contains('رقم الهاتف')) {
        userFriendlyMessage =
            'Invalid phone number format. Please enter a valid phone number.';
      } else if (e.errModel.errorMessage.contains('كلمة المرور')) {
        userFriendlyMessage =
            'Invalid password. Please check your password and try again.';
      } else if (e.errModel.errorMessage.contains('غير موجود')) {
        userFriendlyMessage =
            'Account not found. Please check your phone number or sign up for a new account.';
      }

      return Left(ServerException(
        errModel: ErrorModel(errorMessage: userFriendlyMessage),
      ));
    } catch (e) {
      print('Unexpected error during login: $e');
      return Left(ServerException(
        errModel: ErrorModel(
            errorMessage:
                'Network error. Please check your internet connection and try again.'),
      ));
    }
  }

  Future<Either<ServerException, SignupEntity>> register({
    required String phoneNumber,
    required String password,
    required String name,
    required String experienceYear,
    required String address,
    required String experienceLevel,
  }) async {
    try {
      final requestData = {
        ApiKey.phoneNumber: phoneNumber,
        ApiKey.password: password,
        ApiKey.displyName: name,
        ApiKey.experinceYear: experienceYear,
        ApiKey.address: address,
        ApiKey.expericneLevel: experienceLevel,
      };

      final response =
          await apiConsumer.post(EndPoint.signUp, data: requestData);

      // Add null safety check for response
      if (response == null) {
        return Left(ServerException(
          errModel: ErrorModel(errorMessage: 'Server returned null response'),
        ));
      }

      // Check if response is a Map
      if (response is! Map<String, dynamic>) {
        return Left(ServerException(
          errModel: ErrorModel(
              errorMessage: 'Invalid response format: ${response.runtimeType}'),
        ));
      }

      try {
        final user = SignUpModel.fromJson(response);

        await CacheHelper.saveData(key: ApiKey.id, value: user.id);
        await CacheHelper.saveData(
            key: ApiKey.accessToken, value: user.accessToken);
        await CacheHelper.saveData(
            key: ApiKey.refreshToken, value: user.refreshToken);

        return Right(user);
      } catch (parseError) {
        return Left(ServerException(
          errModel:
              ErrorModel(errorMessage: 'Error parsing response: $parseError'),
        ));
      }
    } on ServerException catch (e) {
      // Handle specific error cases
      String userFriendlyMessage = e.errModel.errorMessage;

      // Check for Arabic error messages and provide English translations
      if (e.errModel.errorMessage.contains('رقم الهاتف مستخدم بالفعل')) {
        userFriendlyMessage =
            'Phone number is already registered. Please use a different phone number or try signing in.';
      } else if (e.errModel.errorMessage.contains('كلمة المرور')) {
        userFriendlyMessage =
            'Password is too weak. Please use a stronger password.';
      } else if (e.errModel.errorMessage.contains('رقم الهاتف')) {
        userFriendlyMessage =
            'Invalid phone number format. Please enter a valid phone number.';
      }

      return Left(ServerException(
        errModel: ErrorModel(errorMessage: userFriendlyMessage),
      ));
    } catch (e) {
      return Left(ServerException(
        errModel: ErrorModel(
            errorMessage:
                'Network error. Please check your internet connection and try again.'),
      ));
    }
  }

  Future<Either<ServerException, void>> logout(
      {required String refreshToken}) async {
    try {
      await apiConsumer
          .post(EndPoint.logout, data: {ApiKey.refreshToken: refreshToken});
      await CacheHelper.removeData(key: ApiKey.accessToken);
      await CacheHelper.removeData(key: ApiKey.refreshToken);
      await CacheHelper.removeData(key: ApiKey.id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerException(errModel: e.errModel));
    }
  }

  Future<Either<ServerException, ProfileEntity>> getProfile() async {
    try {
      final responce = await apiConsumer.get(EndPoint.getProfile);
      final user = ProfileModel.fromJson(responce);
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerException(errModel: e.errModel));
    }
  }
}
