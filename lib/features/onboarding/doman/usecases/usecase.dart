import 'package:injectable/injectable.dart';
import 'package:life_tracking/features/onboarding/data/model/details_model.dart';

import '../../data/repositories/onboarding_repository.dart';

@injectable
class SaveUserUseCase {
  final OnboardingRepository repository;
  SaveUserUseCase(this.repository);

  Future<void> execute(DetailsUserModel user) async {
    await repository.saveUserData(user.toMap());
  }
}
