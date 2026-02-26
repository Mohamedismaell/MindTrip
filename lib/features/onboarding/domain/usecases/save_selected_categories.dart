import 'package:mindtrip/features/onboarding/domain/repositories/onboarding_repository.dart';

class SaveSelectedCategories {
  final OnboardingRepository repo;

  SaveSelectedCategories(this.repo);

  Future<void> call(List<String> categories) {
    return repo.saveSelectedCategories(categories);
  }
}
