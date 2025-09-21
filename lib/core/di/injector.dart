import 'package:get_it/get_it.dart';
import 'package:life_tracking/features/life_celendar/data/datasources/local_db.dart';
import 'package:life_tracking/features/life_celendar/domain/repositories/life_repo_impl.dart';
import 'package:life_tracking/features/life_celendar/domain/repositories/life_repository.dart';
import 'package:life_tracking/features/life_celendar/presentation/bloc/life_bloc.dart';

import '../../features/auth/data/services/auth_service.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // لازم يتسجل الأول
  getIt.registerLazySingleton<AuthService>(() => AuthService());

  // بعده نسجل الـ Bloc
  getIt.registerFactory<AuthBloc>(() => AuthBloc(getIt<AuthService>()));

  // Local DB
  getIt.registerLazySingleton<LocalDb>(() => LocalDb());

  // Repository
  getIt.registerLazySingleton<LifeRepository>(
    () => LifeRepositoryImpl(getIt<LocalDb>()),
  );

  // BLoC
  getIt.registerFactory<LifeBloc>(() => LifeBloc(getIt<LifeRepository>()));
}
