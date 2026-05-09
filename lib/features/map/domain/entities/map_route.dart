import 'package:equatable/equatable.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:mindtrip/features/map/domain/entities/route_step.dart';
import 'navigation_profile.dart';
import 'route_leg.dart';

class MapRoute extends Equatable {
  final List<Position> waypoints;
  final String geoJsonGeometry;
  final double distance;
  final double duration;
  final List<RouteLeg> legs;
  final NavigationProfile profile;

  /// Flattened congestion levels across all legs (driving-traffic only)
  final List<String>? congestionLevels;

  const MapRoute({
    required this.waypoints,
    required this.geoJsonGeometry,
    required this.distance,
    required this.duration,
    required this.legs,
    required this.profile,
    this.congestionLevels,
  });

  /// Returns all steps flattened across all legs
  List<RouteStep> get allSteps => legs.expand((leg) => leg.steps).toList();

  @override
  List<Object?> get props => [
    waypoints,
    geoJsonGeometry,
    distance,
    duration,
    legs,
    profile,
    congestionLevels,
  ];
}
