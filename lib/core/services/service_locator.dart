import 'package:get_it/get_it.dart';
import 'package:life_tracking/features/onboarding/data/repositories/onboarding_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);
  getIt.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepository(prefs: getIt()),
  );
}
