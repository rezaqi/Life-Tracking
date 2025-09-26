// features/auth/presentation/bloc/auth_bloc.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:life_tracking/core/class/faiiur.dart';
import 'package:life_tracking/core/class/local_storage.dart';
import 'package:life_tracking/core/class/request_state.dart';
import 'package:life_tracking/features/auth/data/services/auth_service.dart';
import 'package:life_tracking/features/auth/presentation/bloc/auth_event.dart';
import 'package:life_tracking/features/auth/presentation/bloc/auth_state.dart';

@injectable
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

    on<SignUpRequested>((event, emit) async {
      print("jjjjjjjj");
      emit(state.copyWith(requestStateSignUp: RequestState.loading));
      try {
        print("anana");
        Map<String, dynamic> data = await LocalStorage.getUserData();

        final user = await _authService.signUp(
          //   event.context,
          event.email,
          event.password,
          data['name'],
          data['birthday'],
          data['lifeExpectancy'],
          data['relationship'],
          List<String>.from(data['goals'] ?? []),
          data['haveChildren'] ?? '',
          data['country'] ?? '',
          data['children'] ?? [],
          data['partnerName'] ?? '',
          data['partnerBirthday'] ?? '',
          data['anniversary'] ?? '',
        );

        if (user != null) {
          emit(
            state.copyWith(
              requestStateSignUp: RequestState.success,
              user: user,
            ),
          );

          // ✅ الانتقال مباشرةً لآخر صفحة
          // Navigator.of(
          //   event.context,
          // ).pushReplacementNamed(AppRouts.tabsScreen);
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
      // if (formKey.currentState != null && formKey.currentState!.validate()) {

      // }
    });
  }

  DateTime? safeParseBirthday(String birthday) {
    try {
      // ISO
      return DateTime.parse(birthday);
    } catch (_) {
      try {
        // dd/MM/yyyy
        return DateFormat("d/M/yyyy").parseStrict(birthday);
      } catch (_) {
        return null;
      }
    }
  }
}
