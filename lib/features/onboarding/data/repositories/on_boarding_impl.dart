import 'package:mindtrip/features/onboarding/data/sources/onboarding_local_data_source.dart';
import 'package:mindtrip/features/onboarding/domain/repositories/auth_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDataSource local;

  OnboardingRepositoryImpl({required this.local});

  @override
  Future<bool> isFirstTime() async {
    return local.getIsFirstTime();
  }

  @override
  Future<void> setNotFirstTime() async {
    await local.saveIsFirstTime(false);
  }
}
