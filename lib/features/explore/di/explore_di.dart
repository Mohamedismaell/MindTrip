import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/features/explore/data/datasources/explore_local_data_source.dart';
import 'package:mindtrip/features/explore/data/repositories/explore_repository_impl.dart';
import 'package:mindtrip/features/explore/domain/repositories/explore_repository.dart';
import 'package:mindtrip/features/explore/domain/use_cases/get_tour_packages_use_case.dart';
import 'package:mindtrip/features/explore/presentation/cubit/all_places/explore_all_places_cubit.dart';
import 'package:mindtrip/features/explore/presentation/cubit/explore_cubit.dart';
import 'package:mindtrip/features/places/domain/use_cases/get_popular_places_use_case.dart';
import 'package:mindtrip/features/places/domain/use_cases/get_trending_places_use_case.dart';

class ExploreDi {
  ExploreDi._();

  static void init() {
    //! Data sources
    sl.registerLazySingleton<ExploreLocalDataSource>(
      () => ExploreLocalDataSourceImpl(),
    );

    //! Repositories
    sl.registerLazySingleton<ExploreRepository>(
      () =>
          ExploreRepositoryImpl(localDataSource: sl<ExploreLocalDataSource>()),
    );

    //! Use cases
    sl.registerLazySingleton<GetTourPackagesUseCase>(
      () => GetTourPackagesUseCase(repository: sl<ExploreRepository>()),
    );

    //! Cubit
    sl.registerFactory<ExploreCubit>(
      () => ExploreCubit(getPlacesUseCase: sl<GetPlacesUseCase>()),
    );

    sl.registerFactory<ExploreAllPlacesCubit>(
      () => ExploreAllPlacesCubit(
        getPopularPlacesUseCase: sl<GetPopularPlacesUseCase>(),
      ),
    );
  }
}
