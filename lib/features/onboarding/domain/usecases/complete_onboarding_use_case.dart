import 'package:mindtrip/features/onboarding/domain/repositories/onboarding_repository.dart';

class CompleteOnboardingUseCase {
  final OnboardingRepository repo;

  CompleteOnboardingUseCase(this.repo);

  Future<void> call() {
    return repo.setNotFirstTime();
  }
}
