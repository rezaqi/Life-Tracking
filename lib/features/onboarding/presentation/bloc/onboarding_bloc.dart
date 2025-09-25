import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:life_tracking/core/services/service_locator.dart';
import 'package:life_tracking/features/onboarding/data/repositories/onboarding_repository.dart';

import 'onboarding_event.dart';
import 'onboarding_state.dart';

@injectable
class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final OnboardingRepository repository = getIt<OnboardingRepository>();

  OnboardingBloc(OnboardingRepository onboardingRepository)
    : super(OnboardingInitial()) {
    on<SubmitUserData>((event, emit) async {
      emit(OnboardingLoading());
      try {
        await repository.saveUserData(event.userData);
        emit(OnboardingSuccess());
      } catch (e) {
        emit(OnboardingError(e.toString()));
      }
    });
  }
}
