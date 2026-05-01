import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:mindtrip/core/connections/result.dart';
import '../entities/map_route.dart';

abstract class MapRouteRepository {
  Future<Result<MapRoute>> getRoute(List<Position> waypoints, {String profile = 'driving'});
}
