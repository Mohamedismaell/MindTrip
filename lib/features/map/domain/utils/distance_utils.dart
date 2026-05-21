import 'dart:math';

import 'package:mindtrip/features/map/domain/entities/map_annotation_entry.dart';

class DistanceUtils {
  static double haversineDistance(
    double lat1,
    double lng1,
    double lat2,
    double lng2,
  ) {
    const R = 6371e3; // Earth radius in meters
    final phi1 = lat1 * pi / 180;
    final phi2 = lat2 * pi / 180;
    final deltaPhi = (lat2 - lat1) * pi / 180;
    final deltaLambda = (lng2 - lng1) * pi / 180;

    final a =
        sin(deltaPhi / 2) * sin(deltaPhi / 2) +
        cos(phi1) * cos(phi2) * sin(deltaLambda / 2) * sin(deltaLambda / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return R * c; // Distance in meters
  }

  static MapAnnotationEntry? findNearestAnnotation(
    List<MapAnnotationEntry> annotations,
    double userLat,
    double userLng,
  ) {
    if (annotations.isEmpty) return null;

    MapAnnotationEntry? nearest;
    double minDistance = double.infinity;

    for (final entry in annotations) {
      final distance = haversineDistance(
        userLat,
        userLng,
        entry.place.location.latitude,
        entry.place.location.longitude,
      );
      if (distance < minDistance) {
        minDistance = distance;
        nearest = entry;
      }
    }

    return nearest;
  }
}
