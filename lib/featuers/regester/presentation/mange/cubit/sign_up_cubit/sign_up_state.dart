part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class SignUpLoading extends SignUpState {}

final class SignUpFailure extends SignUpState {
  final String errorMessage;
  SignUpFailure({required this.errorMessage});
}

final class SignUpSuccess extends SignUpState {
  final SignupEntity signupEntity;

  SignUpSuccess({required this.signupEntity});
}
