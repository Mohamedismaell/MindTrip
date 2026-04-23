import 'package:geolocator/geolocator.dart';

abstract class LocationService {
  // Future<bool> checkPermission();
  Future<bool> requestPermission();
  Future<bool> isServiceEnabled();
  Future<Position?> getCurrentLocation();
}
