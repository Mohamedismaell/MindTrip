import 'package:mindtrip/core/database/api/api_consumer.dart';
import 'package:mindtrip/features/places/data/datasources/place_local_data_source.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/features/place_details/data/datasources/place_details_remote_data_source.dart';
import 'package:mindtrip/features/place_details/data/repositories/place_details_repository_impl.dart';
import 'package:mindtrip/features/place_details/domain/repositories/place_details_repository.dart';
import 'package:mindtrip/features/place_details/domain/use_cases/get_nearby_places_use_case.dart';
import 'package:mindtrip/features/place_details/domain/use_cases/get_place_details_use_case.dart';
import 'package:mindtrip/features/place_details/presentation/cubit/place_details_cubit.dart';

class PlaceDetailsDi {
  static void init() {
    // Data sources
    sl.registerLazySingleton<PlaceDetailsRemoteDataSource>(
      () => PlaceDetailsRemoteDataSource(sl<ApiConsumer>()),
    );

    // Repositories
    sl.registerLazySingleton<PlaceDetailsRepository>(
      () => PlaceDetailsRepositoryImpl(
        remote: sl<PlaceDetailsRemoteDataSource>(),
        local: sl<PlaceLocalDataSource>(),
      ),
    );

    // Use cases
    sl.registerLazySingleton<GetPlaceDetailsUseCase>(
      () => GetPlaceDetailsUseCase(repository: sl<PlaceDetailsRepository>()),
    );
    sl.registerLazySingleton<GetNearbyPlacesUseCase>(
      () => GetNearbyPlacesUseCase(repository: sl<PlaceDetailsRepository>()),
    );

    // Cubits
    sl.registerFactory<PlaceDetailsCubit>(
      () => PlaceDetailsCubit(
        getDetails: sl<GetPlaceDetailsUseCase>(),
        getNearby: sl<GetNearbyPlacesUseCase>(),
      ),
    );
  }
}
