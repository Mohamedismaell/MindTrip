import 'package:hive_ce_flutter/adapters.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/routes/app_router.dart';
import 'package:mindtrip/core/shared/presentation/manager/app_gate_cubit/app_gate_cubit.dart';
import 'package:mindtrip/features/onboarding/data/repositories/on_boarding_impl.dart';
import 'package:mindtrip/features/onboarding/data/sources/on_boarding_local_data_source.dart';
import 'package:mindtrip/features/onboarding/data/sources/onboarding_local_data_source.dart';
import 'package:mindtrip/features/onboarding/domain/repositories/auth_repository.dart';
import 'package:mindtrip/features/onboarding/domain/usecases/complete_onboarding_use_case.dart';
import 'package:mindtrip/features/onboarding/presentation/manager/cubit/on_boarding_cubit.dart';

class OnboardingDi {
  OnboardingDi._();

  static void init({required Box<bool> onboardingBox}) {
    sl.registerLazySingleton<Box<bool>>(() => onboardingBox);

    //! Data Sources
    sl.registerLazySingleton<OnboardingLocalDataSource>(
      () => OnboardingLocalDataSourceImpl(box: sl<Box<bool>>()),
    );
    //! Repositories
    sl.registerLazySingleton<OnboardingRepository>(
      () => OnboardingRepositoryImpl(local: sl<OnboardingLocalDataSource>()),
    );
    //! Use Cases
    // sl.registerLazySingleton<CheckFirstTimeUseCase>(
    //   () => CheckFirstTimeUseCase(sl<OnboardingRepository>()),
    // );
    sl.registerLazySingleton<CompleteOnboardingUseCase>(
      () => CompleteOnboardingUseCase(sl<OnboardingRepository>()),
    );
    //!Cubit
    sl.registerLazySingleton<OnboardingCubit>(
      () => OnboardingCubit(sl<CompleteOnboardingUseCase>()),
    );
    sl.registerLazySingleton(
      () => AppGateCubit(onboardingRepository: sl<OnboardingRepository>()),
    );
    sl.registerLazySingleton(() => AppRouter(appGateCubit: sl<AppGateCubit>()));
  }
}
