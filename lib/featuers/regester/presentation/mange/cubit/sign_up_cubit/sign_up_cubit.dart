// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:to_do_app/featuers/regester/domain/entities/sign_up_entity.dart';
import 'package:to_do_app/featuers/regester/domain/repos/auth_repo.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.authRepo) : super(SignUpInitial());
  final AuthRepo authRepo;
  Future<void> register({
    required String name,
    required String phoneNumber,
    required String experienceYear,
    required String experienceLevel,
    required String address,
    required String password,
  }) async {
    emit(SignUpLoading());
    final response = await authRepo.register(
        name: name,
        phoneNumber: phoneNumber,
        experienceYear: experienceYear,
        experienceLevel: experienceLevel,
        address: address,
        password: password);
    response.fold(
      (failure) => emit(
        SignUpFailure(errorMessage: failure.errModel.errorMessage),
      ),
      (success) => emit(
        SignUpSuccess(signupEntity: success), //(),
      ),
    );
  }
}
