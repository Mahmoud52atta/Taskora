import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_app/featuers/home/domain/repos/repo.dart';

part 'delete_state.dart';

class DeleteCubit extends Cubit<DeleteState> {
  DeleteCubit(this.homeRepo) : super(DeleteInitial());
  final HomeRepo homeRepo;

  Future<void> deleteTask({required String id}) async {
    print('DeleteCubit: Starting delete for task ID: $id');
    emit(DeleteLoading());

    final result = await homeRepo.deleteTask(id: id);

    result.fold(
      (failure) {
        print('DeleteCubit: Delete failed - ${failure.errModel.errorMessage}');
        emit(DeleteFailure(message: failure.errModel.errorMessage));
      },
      (success) {
        print('DeleteCubit: Delete successful');
        emit(DeleteSuccess());
      },
    );
  }
}
