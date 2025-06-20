part of 'new_task_cubit.dart';

@immutable
sealed class NewTaskState {}

final class NewTaskInitial extends NewTaskState {}

final class NewTaskLoading extends NewTaskState {}

final class NewTaskSuccess extends NewTaskState {
  final List<AddTaskEntity> addTask;
  NewTaskSuccess({required this.addTask});
}

final class NewTaskFailure extends NewTaskState {
  final String error;

  NewTaskFailure({required this.error});
}
