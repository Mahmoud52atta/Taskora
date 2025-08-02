import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_app/featuers/home/domain/repos/repo.dart';

part 'upload_image_state.dart';

class UploadImageCubit extends Cubit<UploadImageState> {
  UploadImageCubit(this.homeRepo) : super(UploadImageInitial());
  final HomeRepo homeRepo;

  Future<void> uploadImage({required String image}) async {
    emit(UploadImageLoading());
    var result = await homeRepo.uploadImage(image: image);
    result.fold(
      (failure) =>
          emit(UploadImageFailuer(error: failure.errModel.errorMessage)),
      (success) => emit(UploadImageSuccess()),
    );
  }
}
