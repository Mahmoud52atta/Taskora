import 'package:dartz/dartz.dart';
import 'package:to_do_app/core/errors/service_errore.dart';
import 'package:to_do_app/featuers/home/data/data_sources/home_remote_data_source.dart';
import 'package:to_do_app/featuers/home/data/models/upload_image.dart';
import 'package:to_do_app/featuers/home/domain/entities/add_task_entity.dart';
import 'package:to_do_app/featuers/home/domain/entities/edite_entity.dart';
import 'package:to_do_app/featuers/home/domain/entities/hoem_entity.dart';
import 'package:to_do_app/featuers/home/domain/repos/repo.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepoImpl({required this.homeRemoteDataSource});
  @override
  Future<Either<ServerException, List<HomeEntity>>> getHomeDataList() async {
    return await homeRemoteDataSource.getHomeData();
  }

  @override
  Future<Either<ServerException, List<AddTaskEntity>>> addTask(
      {required String image,
      required String title,
      required String description,
      required String priority,
      required String diuDate}) {
    return homeRemoteDataSource.addTask(
      image: image,
      title: title,
      description: description,
      priority: priority,
      diuDate: diuDate,
    );
  }

  @override
  Future<Either<ServerException, void>> deleteTask({required String id}) {
    return homeRemoteDataSource.deleteTask(id: id);
  }

  @override
  Future<Either<ServerException, void>> getHomeDataOne({required String id}) {
    // TODO: implement getHomeDataOne
    throw UnimplementedError();
  }

  @override
  Future<Either<ServerException, List<EditEntity>>> editTask({
    required String id,
    required String image,
    required String title,
    required String description,
    String? status,
    required String priority,
    required String diuDate,
  }) {
    return homeRemoteDataSource.editTask(
      id: id,
      image: image,
      title: title,
      description: description,
      priority: priority,
      status: status,
      diuDate: diuDate,
    );
  }

  @override
  Future<Either<ServerException, UploadImageModel>> uploadImage(
      {required String image}) {
    return homeRemoteDataSource.uploadImage(imagePath: image);
  }
}
