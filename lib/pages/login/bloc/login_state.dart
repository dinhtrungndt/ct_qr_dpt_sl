part of 'login_bloc.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class InitialLoginState extends LoginState {}

class LoginError extends LoginState {
  final String errorMessage;
  LoginError({required this.errorMessage});
}

class LoginWaiting extends LoginState {}

class VerifyServerWaiting extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginModel loginData;
  LoginSuccess({required this.loginData});
}

class SignUpSuccess extends LoginState {}

class SignUpFail extends LoginState {
  final String message;
  SignUpFail({required this.message});
}

class VerifyServerSuccess extends LoginState {}

class VerifyServerFail extends LoginState {}
