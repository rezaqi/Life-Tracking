import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class OnboardingRepository {
  final SharedPreferences prefs;
  OnboardingRepository({required this.prefs});

  Future<void> saveUserData(Map<String, dynamic> data) async {
    prefs.setString('user_data', data.toString());
    prefs.setBool('onboarding_complete', true);
  }

  bool isOnboardingComplete() {
    return prefs.getBool('onboarding_complete') ?? false;
  }
}
