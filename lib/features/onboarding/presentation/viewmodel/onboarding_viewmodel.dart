import 'package:injectable/injectable.dart';

import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';

@injectable
class OnboardingViewModel {
  final OnboardingBloc bloc;

  OnboardingViewModel({required this.bloc});

  void submitData(Map<String, dynamic> data) {
    bloc.add(SubmitUserData(data));
  }
}
