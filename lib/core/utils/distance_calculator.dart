import 'package:geolocator/geolocator.dart';

class DistanceCalculator {
  static double calculateDistance({
    required double startLat,
    required double startLng,
    required double endLat,
    required double endLng,
  }) {
    // Returns distance in meters
    final double distanceInMeters = Geolocator.distanceBetween(
      startLat,
      startLng,
      endLat,
      endLng,
    );
    // Convert to kM
    return distanceInMeters / 1000.0;
  }

  static String formatDistance(double km) {
    if (km < 1.0) {
      return '${(km * 1000).toInt()} m';
    } else {
      return '${km.toStringAsFixed(1)} km';
    }
  }
}
