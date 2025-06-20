import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_app/featuers/home/domain/entities/edite_entity.dart';
import 'package:to_do_app/featuers/home/domain/repos/repo.dart';

part 'edit_state.dart';

class EditCubit extends Cubit<EditState> {
  final HomeRepo homeRepo;

  EditCubit({required this.homeRepo}) : super(EditInitial());

  Future<void> editTask(
      {required String image,
      required String title,
      required String description,
      required String priority,
      required String status,
      required String diuDate}) async {
    emit(EditLoading());
    final result = await homeRepo.editTask(
      image: image,
      title: title,
      description: description,
      priority: priority,
      status: status,
      diuDate: diuDate,
    );
    result.fold(
      (l) => emit(EditFailure(message: l.errModel.errorMessage)),
      (r) => emit(EditSuccess(editeEntity: r)),
    );
  }
}
