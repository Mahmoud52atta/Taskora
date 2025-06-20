import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_app/featuers/regester/domain/repos/auth_repo.dart';

part 'log_out_state.dart';

class LogOutCubit extends Cubit<LogOutState> {
  final AuthRepo authRepo;
  LogOutCubit(this.authRepo) : super(LogOutInitial());
  Future<void> logOut({required String refreshToken}) async {
    emit(LogOutLoading());
    final result = await authRepo.logout(refreshToken: refreshToken);
    result.fold((l) => emit(LogOutFailure(message: l.errModel.errorMessage)),
        (r) => emit(LogOutSuccess()));
  }
}
