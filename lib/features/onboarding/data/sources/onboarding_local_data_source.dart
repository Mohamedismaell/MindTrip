abstract class OnboardingLocalDataSource {
  bool getIsFirstTime();
  Future<void> saveIsFirstTime(bool value);
  Future<void> saveSelectedCategories(List<String> categories);
}
