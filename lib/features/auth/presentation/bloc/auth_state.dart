import 'package:life_tracking/core/class/faiiur.dart';
import 'package:life_tracking/core/class/request_state.dart';
import 'package:life_tracking/features/auth/data/models/user.dart';

class AuthState {
  RequestState? requestStateLogIn;
  RequestState? requestStateSignUp;
  Failure? failureLog;
  Failure? failureSignUp;
  UserModel? user;

  AuthState({
    this.failureLog,
    this.failureSignUp,
    this.requestStateLogIn,
    this.requestStateSignUp,
    this.user,
  });

  AuthState copyWith({
    RequestState? requestStateLogIn,
    RequestState? requestStateSignUp,
    Failure? failureLog,
    Failure? failureSignUp,
    UserModel? user,
  }) {
    return AuthState(
      failureLog: failureLog ?? this.failureLog,
      failureSignUp: failureSignUp ?? this.failureSignUp,
      requestStateLogIn: requestStateLogIn ?? this.requestStateLogIn,
      requestStateSignUp: requestStateSignUp ?? this.requestStateSignUp,
      user: user ?? this.user,
    );
  }
}

class AuthInitial extends AuthState {
  AuthInitial()
    : super(
        requestStateLogIn: RequestState.init,
        requestStateSignUp: RequestState.init,
      );
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
