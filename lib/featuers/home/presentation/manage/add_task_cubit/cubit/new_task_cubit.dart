import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_app/featuers/home/domain/entities/add_task_entity.dart';
import 'package:to_do_app/featuers/home/domain/repos/repo.dart';

part 'new_task_state.dart';

class NewTaskCubit extends Cubit<NewTaskState> {
  NewTaskCubit(this.homeRepo) : super(NewTaskInitial());
  final HomeRepo homeRepo;
  Future<void> addTask({
    required String image,
    required String title,
    required String description,
    required String priority,
    required String diuDate,
  }) async {
    emit(NewTaskLoading());
    final result = await homeRepo.addTask(
      image: image,
      title: title,
      description: description,
      priority: priority,
      diuDate: diuDate,
    );
    result.fold(
      (failure) => emit(NewTaskFailure(error: failure.errModel.errorMessage)),
      (success) => emit(NewTaskSuccess(addTask: success)),
    );
  }
}
