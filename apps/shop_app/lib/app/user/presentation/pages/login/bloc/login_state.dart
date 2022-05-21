part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginLoading extends LoginState {
  final LoginParams params;

  LoginLoading(this.params);
}

class LoginFailure extends LoginState {
  final String message;

  LoginFailure(this.message);
}
