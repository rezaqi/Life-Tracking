import 'package:flutter/cupertino.dart';

abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  LoginRequested(this.email, this.password);
}

class LogoutRequested extends AuthEvent {}

class SignUpRequested extends AuthEvent {
  final BuildContext context;
  final String email;
  final String password;
  final String gender;
  final String country;

  SignUpRequested(
    this.context,
    this.email,
    this.password,
    this.gender,
    this.country,
  );
}
