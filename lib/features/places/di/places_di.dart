import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/features/places/data/datasources/place_local_data_source.dart';
import 'package:mindtrip/features/places/data/datasources/place_remote_data_source.dart';
import 'package:mindtrip/features/places/data/repositories/place_repository_impl.dart';
import 'package:mindtrip/features/places/domain/repositories/place_repository.dart';
import 'package:mindtrip/features/places/domain/use_cases/get_popular_places_use_case.dart';
import 'package:mindtrip/features/places/domain/use_cases/get_recommended_places_use_case.dart';
import 'package:mindtrip/features/places/domain/use_cases/get_trending_places_use_case.dart';
import 'package:mindtrip/features/places/presentation/recommended_places/cubit/recommended_places_cubit.dart';

class PlacesDi {
  PlacesDi._();

  static void init() {
    //! Data sources
    sl.registerLazySingleton<PlaceLocalDataSource>(
      () => PlacesLocalDataSourceImpl(),
    );
    sl.registerLazySingleton<PlaceRemoteDataSource>(
      () => PlaceRemoteDataSourceImpl(api: sl()),
    );

    //! Repositories
    sl.registerLazySingleton<PlaceRepository>(
      () => PlaceRepositoryImpl(
        remoteDataSource: sl<PlaceRemoteDataSource>(),
        localDataSource: sl<PlaceLocalDataSource>(),
      ),
    );

    //! Use cases
    sl.registerLazySingleton<GetPopularPlacesUseCase>(
      () => GetPopularPlacesUseCase(repository: sl<PlaceRepository>()),
    );
    sl.registerLazySingleton<GetRecommendedPlacesUseCase>(
      () => GetRecommendedPlacesUseCase(repository: sl<PlaceRepository>()),
    );
    sl.registerLazySingleton<GetPlacesUseCase>(
      () => GetPlacesUseCase(repository: sl<PlaceRepository>()),
    );

    //! Cubit
    sl.registerFactory<RecommendedPlacesCubit>(
      () => RecommendedPlacesCubit(
        getRecommendedPlacesUseCase: sl<GetRecommendedPlacesUseCase>(),
      ),
    );
  }
}
