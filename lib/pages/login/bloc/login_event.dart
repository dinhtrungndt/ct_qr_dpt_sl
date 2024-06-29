part of 'login_bloc.dart';

abstract class LoginEvent {}

class Login extends LoginEvent {
  final String no_;
  final String password;
  final String site;
  final apiToken;
  Login(this.no_, this.password, this.site, this.apiToken);
}

class SignUpEvent extends LoginEvent {
  final String no_;
  final String password;
  final String saltValue;
  final String name;
  final String code;
  final String attendCode;
  SignUpEvent(this.no_, this.password, this.saltValue, this.name, this.code,
      this.attendCode);
}

class VerifyServer extends LoginEvent {
  String url;
  VerifyServer({required this.url});
}
