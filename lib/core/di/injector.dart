// // import 'package:get_it/get_it.dart';
// // import 'package:life_tracking/features/life_celendar/data/datasources/local_db.dart';
// // import 'package:life_tracking/features/life_celendar/domain/repositories/life_repo_impl.dart';
// // import 'package:life_tracking/features/life_celendar/domain/repositories/life_repository.dart';
// // import 'package:life_tracking/features/life_celendar/presentation/bloc/life_bloc.dart';
// // import 'package:life_tracking/features/onboarding/data/repositories/onboarding_repository.dart';
// // import 'package:life_tracking/features/onboarding/presentation/bloc/onboarding_bloc.dart';
// // import 'package:shared_preferences/shared_preferences.dart';

// // import '../../features/auth/data/services/auth_service.dart';
// // import '../../features/auth/presentation/bloc/auth_bloc.dart';

// // final getIt = GetIt.instance;

// // Future<void> setupDependencies() async {
// //   // SharedPreferences لازم تتحمل الأول
// //   final prefs = await SharedPreferences.getInstance();
// //   getIt.registerLazySingleton<SharedPreferences>(() => prefs);

// //   // Auth
// //   getIt.registerLazySingleton<AuthService>(() => AuthService());
// //   getIt.registerFactory<AuthBloc>(() => AuthBloc(getIt<AuthService>()));

// //   // Local DB
// //   getIt.registerLazySingleton<LocalDb>(() => LocalDb());

// //   // Repositories
// //   getIt.registerLazySingleton<LifeRepository>(
// //     () => LifeRepositoryImpl(getIt<LocalDb>()),
// //   );

// //   // Onboarding Repository
// //   getIt.registerLazySingleton<OnboardingRepository>(
// //     () => OnboardingRepository(prefs: getIt<SharedPreferences>()),
// //   );

// //   // BLoCs
// //   getIt.registerFactory<LifeBloc>(() => LifeBloc(getIt<LifeRepository>()));
// //   getIt.registerFactory<OnboardingBloc>(
// //     () => OnboardingBloc(getIt<OnboardingRepository>()),
// //   );
// // }

// import 'package:get_it/get_it.dart';
// import 'package:injectable/injectable.dart';

// import 'injector.config.dart';

// final getIt = GetIt.instance;

// @InjectableInit()
// Future<void> configureDependencies() async => $initGetIt(getIt);
