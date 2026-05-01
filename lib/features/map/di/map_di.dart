import 'package:dio/dio.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/location/cubit/location_cubit.dart';
import 'package:mindtrip/features/map/Services/location_service/location_service_imp.dart';

import '../data/datasources/map_route_remote_datasource.dart';
import '../data/datasources/map_search_remote_datasource.dart';
import '../data/repositories/map_route_repository_impl.dart';
import '../data/repositories/map_search_repository_impl.dart';
import '../domain/repositories/map_route_repository.dart';
import '../domain/repositories/map_search_repository.dart';
import 'package:mapbox_search/mapbox_search.dart';
import '../presentation/cubit/map_cubit.dart';

class MapDi {
  MapDi._();

  static void init() {
    MapBoxSearch.init(const String.fromEnvironment('ACCESS_TOKEN'));

    sl.registerLazySingleton<LocationService>(() => LocationServiceImp());
    sl.registerLazySingleton<LocationCubit>(
      () => LocationCubit(locationService: sl<LocationService>()),
    );

    // Data sources
    sl.registerLazySingleton<MapSearchRemoteDatasource>(
      () => MapSearchRemoteDatasource(),
    );
    sl.registerLazySingleton<MapRouteRemoteDatasource>(
      () => MapRouteRemoteDatasourceImpl(dio: sl<Dio>()),
    );

    // Repositories
    sl.registerLazySingleton<MapSearchRepository>(
      () => MapSearchRepositoryImpl(remote: sl<MapSearchRemoteDatasource>()),
    );
    sl.registerLazySingleton<MapRouteRepository>(
      () => MapRouteRepositoryImpl(datasource: sl<MapRouteRemoteDatasource>()),
    );

    // Cubits
    sl.registerFactory<MapCubit>(
      () => MapCubit(
        searchRepo: sl<MapSearchRepository>(),
        routeRepo: sl<MapRouteRepository>(),
      ),
    );
  }
}
