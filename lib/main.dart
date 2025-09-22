import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_tracking/app.dart';
import 'package:life_tracking/core/di/injector.dart';
import 'package:life_tracking/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:life_tracking/features/life_celendar/presentation/bloc/life_bloc.dart';
import 'package:life_tracking/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  setupDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LifeBloc>(create: (_) => getIt<LifeBloc>()),
        BlocProvider(create: (_) => getIt<AuthBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}
