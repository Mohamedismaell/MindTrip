import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/features/home/domain/use_cases/get_ai_planner_previews_use_case.dart';
import 'package:mindtrip/features/explore/domain/use_cases/get_tour_packages_use_case.dart';
import 'package:mindtrip/features/home/data/datasources/home_local_data_source.dart';
import 'package:mindtrip/features/home/data/repositories/home_repository_impl.dart';
import 'package:mindtrip/features/home/domain/repositories/home_repository.dart';
import 'package:mindtrip/features/home/domain/use_cases/get_banners_use_case.dart';
import 'package:mindtrip/features/home/presentation/cubit/home_cubit.dart';
import 'package:mindtrip/features/places/domain/use_cases/get_popular_places_use_case.dart';
import 'package:mindtrip/features/places/domain/use_cases/get_recommended_places_use_case.dart';

class HomeDi {
  HomeDi._();

  static void init() {
    //! Data sources
    sl.registerLazySingleton<HomeLocalDataSource>(
      () => HomeLocalDataSourceImpl(),
    );

    //! Repositories
    sl.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(localDataSource: sl<HomeLocalDataSource>()),
    );

    //! Use cases
    sl.registerLazySingleton<GetBannersUseCase>(
      () => GetBannersUseCase(repository: sl<HomeRepository>()),
    );
    sl.registerLazySingleton<GetAIPlannerPreviewsUseCase>(
      () => GetAIPlannerPreviewsUseCase(repository: sl<HomeRepository>()),
    );
    //! Cubit
    sl.registerFactory<HomeCubit>(
      () => HomeCubit(
        getBannersUseCase: sl<GetBannersUseCase>(),
        getPopularPlacesUseCase: sl<GetPopularPlacesUseCase>(),
        getRecommendedPlacesUseCase: sl<GetRecommendedPlacesUseCase>(),
        getTourPackagesUseCase: sl<GetTourPackagesUseCase>(),
        getAIPlannerPreviewsUseCase: sl<GetAIPlannerPreviewsUseCase>(),
      ),
    );
  }
}
