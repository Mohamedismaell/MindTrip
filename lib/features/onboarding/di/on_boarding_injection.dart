import 'package:hive_ce_flutter/adapters.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/features/onboarding/data/repositories/on_boarding_impl.dart';
import 'package:mindtrip/features/onboarding/data/sources/on_boarding_local_data_source.dart';
import 'package:mindtrip/features/onboarding/data/sources/onboarding_local_data_source.dart';
import 'package:mindtrip/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:mindtrip/features/onboarding/domain/usecases/complete_onboarding_use_case.dart';
import 'package:mindtrip/features/onboarding/presentation/manager/cubit/on_boarding_cubit.dart';

class OnboardingDi {
  OnboardingDi._();

  static void init({required Box onboardingBox}) {
    //! Named Box to avoid conflicts with other Hive boxes
    sl.registerLazySingleton<Box>(
      () => onboardingBox,
      instanceName: 'onboardingBox',
    );

    //! Data Sources
    sl.registerLazySingleton<OnboardingLocalDataSource>(
      () => OnboardingLocalDataSourceImpl(
        box: sl<Box>(instanceName: 'onboardingBox'),
      ),
    );

    //! Repositories
    sl.registerLazySingleton<OnboardingRepository>(
      () => OnboardingRepositoryImpl(local: sl<OnboardingLocalDataSource>()),
    );

    //! Use Cases
    sl.registerLazySingleton<CompleteOnboardingUseCase>(
      () => CompleteOnboardingUseCase(sl<OnboardingRepository>()),
    );

    //! Cubit — registerFactory so it resets on each navigation
    sl.registerFactory<OnboardingCubit>(
      () => OnboardingCubit(
        completeOnboarding: sl<CompleteOnboardingUseCase>(),
      ),
    );
  }
}
