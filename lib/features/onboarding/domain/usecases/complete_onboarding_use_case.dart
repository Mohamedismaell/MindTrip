import 'package:ttproj/features/onboarding/domain/repositories/auth_repository.dart';

class CompleteOnboardingUseCase {
  final OnboardingRepository repo;

  CompleteOnboardingUseCase(this.repo);

  Future<void> call() {
    return repo.setNotFirstTime();
  }
}
