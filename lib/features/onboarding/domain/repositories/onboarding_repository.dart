abstract class OnboardingRepository {
  Future<bool> isFirstTime();
  Future<void> setNotFirstTime();
}
