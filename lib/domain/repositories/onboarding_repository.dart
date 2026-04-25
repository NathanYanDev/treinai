import '../models/user_onboarding.dart';

abstract class OnboardingRepository {
  Future<UserOnboarding?> getOnboarding(String userId);
  Future<UserOnboarding> saveOnboarding(UserOnboarding onboarding);
}
