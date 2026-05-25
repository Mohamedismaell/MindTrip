import 'package:dio/dio.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/location/cubit/location_cubit.dart';
import 'package:mindtrip/features/map/Services/location_service/location_service_imp.dart';
import 'package:mindtrip/features/map/domain/use_cases/fetch_place_details_use_case.dart';
import 'package:mindtrip/features/map/domain/use_cases/fetch_place_photo_urls_use_case.dart';
import 'package:mindtrip/features/map/domain/use_cases/find_autocomplete_predictions_use_case.dart';
import 'package:mindtrip/features/map/domain/use_cases/get_route_use_case.dart';
import 'package:mindtrip/features/map/domain/use_cases/nearby_search_use_case.dart';

import '../data/datasources/map_route_remote_datasource.dart';
import '../data/datasources/google_places_datasource.dart';
import '../data/repositories/map_route_repository_impl.dart';
import '../data/repositories/google_places_repository_impl.dart';
import '../domain/repositories/map_route_repository.dart';
import '../domain/repositories/google_places_repository.dart';
import '../presentation/cubit/map_cubit.dart';
import '../presentation/cubit/map_search_cubit.dart';
import '../presentation/cubit/map_navigation_cubit.dart';

class MapDi {
  MapDi._();

  static void init() {
    sl.registerLazySingleton<LocationService>(() => LocationServiceImp());
    sl.registerLazySingleton<LocationCubit>(
      () => LocationCubit(locationService: sl<LocationService>()),
    );

    // Data sources
    sl.registerLazySingleton<GooglePlacesRemoteDatasource>(
      () => GooglePlacesRemoteDatasource(dio: sl<Dio>()),
    );
    sl.registerLazySingleton<MapRouteRemoteDatasource>(
      () => MapRouteRemoteDatasourceImpl(dio: sl<Dio>()),
    );

    // Repositories
    sl.registerLazySingleton<GooglePlacesRepository>(
      () => GooglePlacesRepositoryImpl(
        datasource: sl<GooglePlacesRemoteDatasource>(),
      ),
    );
    sl.registerLazySingleton<MapRouteRepository>(
      () => MapRouteRepositoryImpl(datasource: sl<MapRouteRemoteDatasource>()),
    );
    sl.registerLazySingleton<GetRouteUseCase>(
      () => GetRouteUseCase(routeRepo: sl<MapRouteRepository>()),
    );
    sl.registerLazySingleton<FindAutocompletePredictionsUseCase>(
      () => FindAutocompletePredictionsUseCase(
        repository: sl<GooglePlacesRepository>(),
      ),
    );
    sl.registerLazySingleton<FetchPlaceDetailsUseCase>(
      () => FetchPlaceDetailsUseCase(repository: sl<GooglePlacesRepository>()),
    );
    sl.registerLazySingleton<FetchPlacePhotoUrlsUseCase>(
      () =>
          FetchPlacePhotoUrlsUseCase(repository: sl<GooglePlacesRepository>()),
    );
    sl.registerLazySingleton<NearbySearchUseCase>(
      () => NearbySearchUseCase(repository: sl<GooglePlacesRepository>()),
    );

    // Cubits
    sl.registerFactory<MapCubit>(
      () => MapCubit(
        fetchPlacePhotoUrlsUseCase: sl<FetchPlacePhotoUrlsUseCase>(),
      ),
    );
    sl.registerFactory<MapSearchCubit>(
      () => MapSearchCubit(
        findAutocompletePredictionsUseCase:
            sl<FindAutocompletePredictionsUseCase>(),
        fetchPlaceDetailsUseCase: sl<FetchPlaceDetailsUseCase>(),
        nearbySearchUseCase: sl<NearbySearchUseCase>(),
      ),
    );

    sl.registerFactory<MapNavigationCubit>(
      () => MapNavigationCubit(
        getRouteUseCase: sl<GetRouteUseCase>(),
        locationService: sl<LocationService>(),
      ),
    );
  }
}
