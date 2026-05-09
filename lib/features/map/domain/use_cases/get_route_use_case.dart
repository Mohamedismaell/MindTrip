import 'package:dio/dio.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/map/domain/entities/map_route.dart';
import 'package:mindtrip/features/map/domain/entities/navigation_profile.dart';
import 'package:mindtrip/features/map/domain/repositories/map_route_repository.dart';

class GetRouteUseCase {
  final MapRouteRepository routeRepo;
  GetRouteUseCase({required this.routeRepo});
  Future<Result<MapRoute>> call(
    List<Position> waypoints, {
    NavigationProfile profile = NavigationProfile.driving,
    CancelToken? cancelToken,
  }) {
    return routeRepo.getRoute(
      waypoints,
      profile: profile,
      cancelToken: cancelToken,
    );
  }
}
