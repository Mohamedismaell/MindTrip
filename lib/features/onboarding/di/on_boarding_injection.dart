import 'package:hive_ce_flutter/adapters.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/routes/app_router.dart';
import 'package:mindtrip/core/shared/presentation/manager/app_gate_cubit/app_gate_cubit.dart';
import 'package:mindtrip/features/authetication/presentation/cubit/auth_cubit.dart';
import 'package:mindtrip/features/onboarding/data/repositories/on_boarding_impl.dart';
import 'package:mindtrip/features/onboarding/data/sources/on_boarding_local_data_source.dart';
import 'package:mindtrip/features/onboarding/data/sources/onboarding_local_data_source.dart';
import 'package:mindtrip/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:mindtrip/features/onboarding/domain/usecases/complete_onboarding_use_case.dart';
import 'package:mindtrip/features/onboarding/domain/usecases/save_selected_categories.dart';
import 'package:mindtrip/features/onboarding/presentation/manager/cubit/on_boarding_cubit.dart';

class OnboardingDi {
  OnboardingDi._();

  static void init({required Box onboardingBox}) {
    sl.registerLazySingleton<Box>(() => onboardingBox);

    //! Data Sources
    sl.registerLazySingleton<OnboardingLocalDataSource>(
      () => OnboardingLocalDataSourceImpl(box: sl<Box>()),
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
    sl.registerLazySingleton<SaveSelectedCategories>(
      () => SaveSelectedCategories(sl<OnboardingRepository>()),
    );
    //!Cubit
    sl.registerLazySingleton<OnboardingCubit>(
      () => OnboardingCubit(
        completeOnboarding: sl<CompleteOnboardingUseCase>(),
        saveSelectedCategories: sl<SaveSelectedCategories>(),
      ),
    );
    sl.registerLazySingleton(
      () => AppGateCubit(
        onboardingRepository: sl<OnboardingRepository>(),
        authCubit: sl<AuthCubit>(),
      ),
    );
    sl.registerLazySingleton(() => AppRouter(appGateCubit: sl<AppGateCubit>()));
  }
}
