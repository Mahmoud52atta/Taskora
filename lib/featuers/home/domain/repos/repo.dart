import 'package:dartz/dartz.dart';
import 'package:to_do_app/core/errors/service_errore.dart';
import 'package:to_do_app/featuers/home/data/models/upload_image.dart';
import 'package:to_do_app/featuers/home/domain/entities/add_task_entity.dart';
import 'package:to_do_app/featuers/home/domain/entities/edite_entity.dart';
import 'package:to_do_app/featuers/home/domain/entities/hoem_entity.dart';

abstract class HomeRepo {
  Future<Either<ServerException, List<HomeEntity>>> getHomeDataList();
  Future<Either<ServerException, void>> getHomeDataOne({required String id});
  Future<Either<ServerException, List<AddTaskEntity>>> addTask({
    required String image,
    required String title,
    required String description,
    required String priority,
    required String diuDate,
  });
  Future<Either<ServerException, void>> deleteTask({required String id});
  Future<Either<ServerException, List<EditEntity>>> editTask({
    required String id,
    required String image,
    required String title,
    required String description,
    String? status,
    required String priority,
    required String diuDate,
  });
  Future<Either<ServerException, UploadImageModel>> uploadImage(
      {required String image});
}
