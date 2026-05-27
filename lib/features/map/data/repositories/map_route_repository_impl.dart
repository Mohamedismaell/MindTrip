import 'package:dio/dio.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/database/api/api_error_mapper.dart';
import '../../domain/entities/map_route.dart';
import '../../domain/entities/navigation_profile.dart';
import '../../domain/repositories/map_route_repository.dart';
import '../datasources/map_route_remote_datasource.dart';

class MapRouteRepositoryImpl implements MapRouteRepository {
  final MapRouteRemoteDatasource datasource;

  MapRouteRepositoryImpl({required this.datasource});

  @override
  Future<Result<MapRoute>> getRoute(
    List<Position> waypoints, {
    NavigationProfile profile = NavigationProfile.driving,
    CancelToken? cancelToken,
  }) async {
    try {
      final route = await datasource.getRoute(
        waypoints,
        profile,
        cancelToken: cancelToken,
      );
      return Result.ok(route);
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }
}
