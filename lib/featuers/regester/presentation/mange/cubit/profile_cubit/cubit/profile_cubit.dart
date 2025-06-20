import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_app/featuers/regester/domain/entities/profile_entity.dart';
import 'package:to_do_app/featuers/regester/domain/repos/auth_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthRepo authRepo;
  ProfileCubit(this.authRepo) : super(ProfileInitial());
  Future<void> getProfile() async {
    emit(ProfileLoading());

    final result = await authRepo.getProfile();
    result.fold((l) => emit(ProfileFailure(message: l.errModel.errorMessage)),
        (r) => emit(ProfileSuccess(profile: r)));
  }
}
