// features/auth/presentation/bloc/auth_bloc.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_tracking/core/class/faiiur.dart';
import 'package:life_tracking/core/class/request_state.dart';
import 'package:life_tracking/features/auth/data/services/auth_service.dart';
import 'package:life_tracking/features/auth/presentation/bloc/auth_event.dart';
import 'package:life_tracking/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;
  final emailC = TextEditingController();
  final passC = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static AuthBloc get(context) => BlocProvider.of(context);
  AuthBloc(this._authService) : super(AuthInitial()) {
    // 🔹 تسجيل الدخول
    on<LoginRequested>((event, emit) async {
      if (formKey.currentState!.validate()) {
        emit(state.copyWith(requestStateLogIn: RequestState.loading));
        try {
          final user = await _authService.login(event.email, event.password);
          if (user != null) {
            emit(
              state.copyWith(
                requestStateLogIn: RequestState.success,
                user: user,
              ),
            );
          } else {
            emit(
              state.copyWith(
                requestStateLogIn: RequestState.error,
                failureLog: Failure("Login failed"),
              ),
            );
          }
        } catch (e) {
          emit(
            state.copyWith(
              requestStateLogIn: RequestState.error,
              failureLog: Failure(e.toString()),
            ),
          );
        }
      }
    });

    // 🔹 تسجيل الخروج
    on<LogoutRequested>((event, emit) async {
      await _authService.logout();
      emit(
        state.copyWith(
          user: null,
          requestStateLogIn: RequestState.init,
          requestStateSignUp: RequestState.init,
        ),
      );
    });

    // 🔹 إنشاء حساب جديد
    on<SignUpRequested>((event, emit) async {
      if (formKey.currentState!.validate()) {
        emit(state.copyWith(requestStateSignUp: RequestState.loading));
        try {
          final user = await _authService.signUp(
            event.email,
            event.password,
            event.username,
          );
          if (user != null) {
            emit(
              state.copyWith(
                requestStateSignUp: RequestState.success,
                user: user,
              ),
            );
          } else {
            emit(
              state.copyWith(
                requestStateSignUp: RequestState.error,
                failureSignUp: Failure("Signup failed"),
              ),
            );
          }
        } catch (e) {
          emit(
            state.copyWith(
              requestStateSignUp: RequestState.error,
              failureSignUp: Failure(e.toString()),
            ),
          );
        }
      }
    });
  }
}
