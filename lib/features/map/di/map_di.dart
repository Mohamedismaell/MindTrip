import 'package:dio/dio.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/location/cubit/location_cubit.dart';
import 'package:mindtrip/features/map/Services/location_service/location_service_imp.dart';

import '../data/datasources/map_route_remote_datasource.dart';
import '../data/datasources/google_places_datasource.dart';
import '../data/repositories/map_route_repository_impl.dart';
import '../data/repositories/google_places_repository_impl.dart';
import '../domain/repositories/map_route_repository.dart';
import '../domain/repositories/google_places_repository.dart';
import '../presentation/cubit/map_cubit.dart';

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

    // Cubits
    sl.registerFactory<MapCubit>(
      () => MapCubit(
        searchRepo: sl<GooglePlacesRepository>(),
        routeRepo: sl<MapRouteRepository>(),
      ),
    );
  }
}
