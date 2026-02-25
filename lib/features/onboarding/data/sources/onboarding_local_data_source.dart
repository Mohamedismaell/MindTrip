abstract class OnboardingLocalDataSource {
  bool getIsFirstTime();
  Future<void> saveIsFirstTime(bool value);
}
