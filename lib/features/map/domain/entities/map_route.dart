import 'package:equatable/equatable.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class MapRoute extends Equatable {
  final List<Position> waypoints;
  final String geoJsonGeometry;
  final double distance;
  final double duration;

  const MapRoute({
    required this.waypoints,
    required this.geoJsonGeometry,
    required this.distance,
    required this.duration,
  });

  @override
  List<Object?> get props => [waypoints, geoJsonGeometry, distance, duration];
}
