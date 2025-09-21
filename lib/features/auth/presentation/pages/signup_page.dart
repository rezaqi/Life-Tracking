import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_tracking/core/class/request_state.dart';
import 'package:life_tracking/core/class/routs_name.dart';
import 'package:life_tracking/core/di/injector.dart';
import 'package:life_tracking/core/widgets/custom_text_field.dart';
import 'package:life_tracking/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:life_tracking/features/auth/presentation/bloc/auth_event.dart';
import 'package:life_tracking/features/auth/presentation/bloc/auth_state.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authBloc = getIt<AuthBloc>();

    return Scaffold(
      appBar: AppBar(title: const Text("إنشاء حساب")),
      body: BlocProvider.value(
        value: authBloc,
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.requestStateSignUp == RequestState.success &&
                state.user != null) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRouts.lifeCalendarPage,

                (rout) => false,
              );
            } else if (state.requestStateSignUp == RequestState.error &&
                state.failureSignUp != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.failureSignUp!.message)),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CustomTextField(
                  controller: usernameController,
                  hint: "اسم المستخدم",
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  controller: emailController,
                  hint: "البريد الإلكتروني",
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  controller: passwordController,
                  hint: "كلمة المرور",
                  obscure: true,
                ),
                const SizedBox(height: 20),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state.requestStateSignUp == RequestState.loading) {
                      return const CircularProgressIndicator();
                    }
                    return ElevatedButton(
                      onPressed: () {
                        authBloc.add(
                          SignUpRequested(
                            emailController.text,
                            passwordController.text,
                            usernameController.text,
                          ),
                        );
                      },
                      child: const Text("إنشاء حساب"),
                    );
                  },
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("لديك حساب؟ تسجيل الدخول"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
