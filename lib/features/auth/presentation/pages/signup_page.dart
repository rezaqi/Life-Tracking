// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:life_tracking/core/class/request_state.dart';
// import 'package:life_tracking/core/class/validator.dart';
// import 'package:life_tracking/core/services/service_locator.dart';
// import 'package:life_tracking/core/widgets/custom_text_field.dart';
// import 'package:life_tracking/features/auth/presentation/bloc/auth_bloc.dart';
// import 'package:life_tracking/features/auth/presentation/bloc/auth_event.dart';
// import 'package:life_tracking/features/auth/presentation/bloc/auth_state.dart';
// import 'package:life_tracking/features/dashboard/const/countries.dart';

// class SignUpPage extends StatefulWidget {
//   SignUpPage({super.key});

//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {

//   final usernameController = TextEditingController();

//   final ageController = TextEditingController();
//   String? gender;
//   String? country;

//   @override
//   Widget build(BuildContext context) {
//     final authBloc = getIt<AuthBloc>();

//     return Scaffold(
//       appBar: AppBar(title: const Text("Sign Up")),
//       body: BlocProvider.value(
//         value: authBloc,
//         child: BlocListener<AuthBloc, AuthState>(
//           listener: (context, state) {
//             if (state.requestStateSignUp == RequestState.success &&
//                 state.user != null) {
//               // Navigator.pushNamedAndRemoveUntil(
//               //   context,
//               //   AppRouts.lifeCalendarPage,

//               //   (rout) => false,
//               // );
//             } else if (state.requestStateSignUp == RequestState.error &&
//                 state.failureSignUp != null) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text(state.failureSignUp!.message)),
//               );
//             }
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Form(
//               key: authBloc.formKey,
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Expanded(
//                             child: DropdownButton<String>(
//                               value: gender,
//                               hint: const Text('Select Gender'),
//                               items: ['Male', 'Female', 'Other']
//                                   .map(
//                                     (e) => DropdownMenuItem(
//                                       value: e,
//                                       child: Text(e),
//                                     ),
//                                   )
//                                   .toList(),
//                               onChanged: (val) => setState(() => gender = val),
//                             ),
//                           ),
//                           Expanded(
//                             child: DropdownButton<String>(
//                               value: country,
//                               hint: Text('Select Country'),
//                               items: countries
//                                   .map(
//                                     (e) => DropdownMenuItem(
//                                       value: e,
//                                       child: Text(e),
//                                     ),
//                                   )
//                                   .toList(),
//                               onChanged: (val) => setState(() => country = val),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 12),

//                     const SizedBox(height: 20),
//                     BlocBuilder<AuthBloc, AuthState>(
//                       builder: (context, state) {
//                         if (state.requestStateSignUp == RequestState.loading) {
//                           return const CircularProgressIndicator();
//                         }
//                         return ElevatedButton(
//                           onPressed: () {
//                             if (gender == null || gender!.isEmpty) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                   content: Text("⚠️ Please select your gender"),
//                                 ),
//                               );
//                               return;
//                             }

//                             if (country == null || country!.isEmpty) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                   content: Text(
//                                     "⚠️ Please select your country",
//                                   ),
//                                 ),
//                               );
//                               return;
//                             }

//                             authBloc.add(
//                               SignUpRequested(
//                                 context,
//                                 emailController.text,
//                                 passwordController.text,
//                                 gender!,
//                                 country!,
//                               ),
//                             );
//                           },
//                           child: const Text("Sign up"),
//                         );
//                       },
//                     ),
//                     TextButton(
//                       onPressed: () => Navigator.pop(context),
//                       child: const Text("you already have an account, LogIn"),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
