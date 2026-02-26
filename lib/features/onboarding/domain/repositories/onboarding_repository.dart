abstract class OnboardingRepository {
  Future<bool> isFirstTime();
  Future<void> setNotFirstTime();
  Future<void> saveSelectedCategories(List<String> categories);
}
