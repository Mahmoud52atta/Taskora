import 'package:dartz/dartz.dart';
import 'package:to_do_app/core/api/api_consumer.dart';
import 'package:to_do_app/core/api/end_point.dart';
import 'package:to_do_app/core/cash/cash_helper.dart';
import 'package:to_do_app/core/errors/error_model.dart';
import 'package:to_do_app/core/errors/service_errore.dart';
import 'package:to_do_app/featuers/home/data/models/add_task_model.dart';
import 'package:to_do_app/featuers/home/data/models/edite_model.dart';
import 'package:to_do_app/featuers/home/data/models/home_model.dart';
import 'package:to_do_app/featuers/home/data/models/upload_image.dart';
import 'package:to_do_app/featuers/home/domain/entities/add_task_entity.dart';
import 'package:to_do_app/featuers/home/domain/entities/edite_entity.dart';
import 'package:to_do_app/featuers/home/domain/entities/hoem_entity.dart';

class HomeRemoteDataSource {
  final ApiConsumer apiConsumer;

  HomeRemoteDataSource({required this.apiConsumer});

  Future<Either<ServerException, List<HomeEntity>>> getHomeData(
      {int page = 1}) async {
    try {
      final response = await apiConsumer.get(
        '${EndPoint.getHomeData}?page=$page',
      );
      final todos =
          (response as List).map((item) => HomeModel.fromJson(item)).toList();
      return Right(todos);
    } on ServerException catch (e) {
      return Left(ServerException(errModel: e.errModel));
    }
  }

  Future<Either<ServerException, List<AddTaskEntity>>> addTask({
    required String image,
    required String title,
    required String description,
    required String priority,
    required String diuDate,
  }) async {
    try {
      final response = await apiConsumer.post(
        EndPoint.addTask,
        data: {
          'image': image,
          'title': title,
          'desc': description,
          'priority': priority,
          'dueDate': diuDate,
        },
      );

      List<AddTaskModel> todos;
      if (response is List) {
        todos = response.map((item) => AddTaskModel.fromJson(item)).toList();
      } else if (response is Map<String, dynamic>) {
        todos = [AddTaskModel.fromJson(response)];
      } else {
        todos = [];
      }
      await CacheHelper.saveData(
          key: ApiKey.id, value: todos.map((e) => e.id).toList());
      return Right(todos);
    } on ServerException catch (e) {
      return Left(ServerException(errModel: e.errModel));
    }
  }

  Future<Either<ServerException, List<EditEntity>>> editTask({
    required String id,
    required String image,
    required String title,
    required String description,
    required String priority,
    String? status,
    required String diuDate,
  }) async {
    try {
      final response = await apiConsumer.put(
        '${EndPoint.editTask}$id',
        data: {
          'image': image,
          'title': title,
          'desc': description,
          'priority': priority,
          'status': status ?? 'waiting',
          'dueDate': diuDate,
        },
      );
      List<EditeModel> todos;
      if (response is List) {
        todos = response.map((item) => EditeModel.fromJson(item)).toList();
      } else if (response is Map<String, dynamic>) {
        todos = [EditeModel.fromJson(response)];
      } else {
        todos = [];
      }
      final idTask = await CacheHelper.saveData(
          key: ApiKey.id, value: todos.map((e) => e.id).toList());
      print('id: $idTask');
      return Right(todos);
    } on ServerException catch (e) {
      return Left(ServerException(errModel: e.errModel));
    }
  }

  Future<Either<ServerException, void>> deleteTask({required String id}) async {
    try {
      print('Deleting task with ID: $id');
      print('Delete URL: ${EndPoint.deleteTask}$id');

      await apiConsumer.delete('${EndPoint.deleteTask}$id');

      print('Task deleted successfully');
      return Right(null);
    } on ServerException catch (e) {
      print('Delete task failed: ${e.errModel.errorMessage}');
      return Left(ServerException(errModel: e.errModel));
    } catch (e) {
      print('Unexpected error during delete: $e');
      return Left(
          ServerException(errModel: ErrorModel(errorMessage: e.toString())));
    }
  }

  Future<Either<ServerException, UploadImageModel>> uploadImage(
      {required String imagePath}) async {
    try {
      final response = await apiConsumer.post(
        EndPoint.uploadImage,
        data: {'image': imagePath},
      );
      if (response is Map<String, dynamic>) {
        return Right(UploadImageModel.fromJson(response));
      } else {
        return Left(ServerException(
            errModel: ErrorModel(errorMessage: 'Invalid response format')));
      }
    } on ServerException catch (e) {
      return Left(ServerException(errModel: e.errModel));
    } catch (e) {
      return Left(
          ServerException(errModel: ErrorModel(errorMessage: e.toString())));
    }
  }
}
