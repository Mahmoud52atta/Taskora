import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_app/featuers/regester/data/repo/auth_repo_imp.dart';
import 'package:to_do_app/featuers/regester/domain/entities/login_entity.dart';

part 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit(this.authRepoImp) : super(LogInInitial());
  final AuthRepoImp authRepoImp;
  Future<void> logIn({required String phone, required String password}) async {
    emit(LogInLoading());
    final result = await authRepoImp.login(phone: phone, password: password);
    result.fold(
      (failure) => emit(
        LogInFailure(errorMessage: failure.errModel.errorMessage),
      ),
      (success) => emit(
        LogInSuccess(loginEntities: success),
      ),
    );
  }
}
