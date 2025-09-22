import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_tracking/core/class/request_state.dart';
import 'package:life_tracking/core/class/routs_name.dart';
import 'package:life_tracking/core/class/validator.dart';
import 'package:life_tracking/features/auth/presentation/bloc/auth_event.dart';
import 'package:life_tracking/features/auth/presentation/bloc/auth_state.dart';

import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.requestStateLogIn == RequestState.success &&
                state.user != null) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRouts.lifeCalendarPage,
                (rout) => false,
              );
            }
          },
          builder: (context, state) {
            var bloc = AuthBloc.get(context);
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: bloc.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FlutterLogo(size: 70),
                    const SizedBox(height: 20),

                    // ✅ رسالة خطأ عند الفشل
                    if (state.requestStateLogIn == RequestState.error &&
                        state.failureLog != null)
                      Text(
                        state.failureLog!.message,
                        style: const TextStyle(color: Colors.red),
                      ),

                    CustomTextField(
                      validator: Validators.email,
                      controller: bloc.emailC,
                      hint: "Email",
                      icon: Icons.email,
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      validator: Validators.password,
                      controller: bloc.passC,
                      hint: "Password",
                      obscure: true,
                      icon: Icons.lock,
                    ),
                    const SizedBox(height: 20),

                    CustomButton(
                      text: "Login",
                      loading: state.requestStateLogIn == RequestState.loading,
                      onPressed: () {
                        context.read<AuthBloc>().add(
                          LoginRequested(bloc.emailC.text, bloc.passC.text),
                        );
                      },
                    ),

                    const SizedBox(height: 12),

                    // ✅ زر تسجيل حساب جديد
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/signup");
                      },
                      child: const Text("Don’t have an account? Sign Up"),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
