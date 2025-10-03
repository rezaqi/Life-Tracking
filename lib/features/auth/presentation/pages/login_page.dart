import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_tracking/core/class/colors.dart';
import 'package:life_tracking/core/class/routs_name.dart';
import 'package:life_tracking/core/class/text.dart';
import 'package:life_tracking/core/class/validator.dart';
import 'package:life_tracking/core/widgets/custom_text_field.dart';
import 'package:life_tracking/features/auth/presentation/bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.pri, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthLoading) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) =>
                      const Center(child: CircularProgressIndicator()),
                );
              } else {
                Navigator.of(context, rootNavigator: true).pop();
                if (state is AuthAuthenticated) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRouts.tabsScreen,
                    (r) => false,
                  );
                } else if (state is AuthError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              }
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 60.h),
                    Icon(Icons.lock_outline, size: 80.sp, color: AppColors.pri),
                    SizedBox(height: 20.h),
                    Text(
                      'Welcome Back',
                      style: Styles.titleStyle.copyWith(fontSize: 28.sp),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Sign in to continue your journey',
                      style: Styles.subtitleStyle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40.h),
                    CustomTextField(
                      controller: _emailController,
                      hint: "Email",
                      validator: Validators.email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      controller: _passwordController,
                      hint: "Password",
                      validator: Validators.password,
                      obscure: true,
                    ),
                    SizedBox(height: 32.h),
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.pri,
                        foregroundColor: Colors.white,
                        minimumSize: Size(double.infinity, 50.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text('Login', style: Styles.buttonText),
                    ),
                    SizedBox(height: 20.h),
                    TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, AppRouts.introScreen),
                      child: Text(
                        "Don't have an account? Sign Up",
                        style: TextStyle(color: AppColors.pri, fontSize: 16.sp),
                      ),
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

  void _login() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        LoginRequested(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        ),
      );
    }
  }
}
