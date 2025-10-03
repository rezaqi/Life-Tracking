part of 'auth_bloc.dart';

abstract class AuthEvent {}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;

  SignUpRequested(this.email, this.password);
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested(this.email, this.password);
}

class LogoutRequested extends AuthEvent {
  BuildContext context;
  LogoutRequested(this.context);
}

class CheckAuthStatus extends AuthEvent {}
