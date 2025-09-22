import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_tracking/core/class/request_state.dart';
import 'package:life_tracking/core/class/routs_name.dart';
import 'package:life_tracking/core/class/validator.dart';
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
      appBar: AppBar(title: const Text("Sign Up")),
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
            child: Form(
              key: authBloc.formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTextField(
                      validator: Validators.name,
                      controller: usernameController,
                      hint: "name",
                    ),
                    const SizedBox(height: 12),

                    CustomTextField(
                      validator: Validators.name,
                      controller: usernameController,
                      hint: "age",
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      validator: Validators.email,

                      controller: emailController,
                      hint: "email",
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      validator: Validators.password,

                      controller: passwordController,
                      hint: "password",
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
                          child: const Text("Sign up"),
                        );
                      },
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("you already have an account, LogIn"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
