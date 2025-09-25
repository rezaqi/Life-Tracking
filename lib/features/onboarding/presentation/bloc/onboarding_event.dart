abstract class OnboardingEvent {}

class SubmitUserData extends OnboardingEvent {
  final Map<String, dynamic> userData;
  SubmitUserData(this.userData);
}
