part of 'log_in_cubit.dart';

@immutable
sealed class LogInState {}

final class LogInInitial extends LogInState {}
final class LogInLoading extends LogInState {}
final class LogInFailure extends LogInState {
  final String errorMessage;

  LogInFailure({required this.errorMessage});
}
final class LogInSuccess extends LogInState {  final LoginEntity loginEntities;

  LogInSuccess({required this.loginEntities});

 }
