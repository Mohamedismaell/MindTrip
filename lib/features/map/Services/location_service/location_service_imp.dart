import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mindtrip/features/map/presentation/models/location_result.dart';

enum LocationAccessStatus { granted, denied, deniedForever, serviceDisabled }

abstract class LocationService {
  Future<LocationAccessStatus> checkAccess();
  Future<Position?> getCurrentLocation();
  Future<LocationResult?> getCurrentLocationDetails();

  Stream<Position> getPositionStream({
    LocationAccuracy accuracy = LocationAccuracy.high,
    int distanceFilter = 8,
  });

  double? getDistanceBetween({
    required double userLat,
    required double userLng,
    required double placeLat,
    required double placeLng,
  });
}

class LocationServiceImp implements LocationService {
  @override
  Future<LocationAccessStatus> checkAccess() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return LocationAccessStatus.serviceDisabled;
    }

    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      return LocationAccessStatus.denied;
    }

    if (permission == LocationPermission.deniedForever) {
      return LocationAccessStatus.deniedForever;
    }

    return LocationAccessStatus.granted;
  }

  @override
  Future<Position?> getCurrentLocation() async {
    try {
      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 15),
        ),
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Stream<Position> getPositionStream({
    LocationAccuracy accuracy = LocationAccuracy.high,
    int distanceFilter = 8,
  }) {
    return Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: accuracy,
        distanceFilter: distanceFilter,
      ),
    );
  }

  @override
  Future<LocationResult?> getCurrentLocationDetails() async {
    try {
      final position = await getCurrentLocation();
      if (position == null) return null;

      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isEmpty) return null;

      final place = placemarks.first;
      return LocationResult(
        latitude: position.latitude,
        longitude: position.longitude,
        country: place.country ?? '',
        city: _resolveCity(place),
      );
    } catch (_) {
      return null;
    }
  }

  String _resolveCity(Placemark place) {
    final raw =
        place.administrativeArea ??
        place.locality ??
        place.subAdministrativeArea ??
        '';
    return _cleanCityName(raw);
  }

  String _cleanCityName(String name) {
    if (name.isEmpty) return '';
    return name.replaceAll('Governorate', '').replaceAll(' محافظة', '').trim();
  }

  @override
  double? getDistanceBetween({
    required double userLat,
    required double userLng,
    required double placeLat,
    required double placeLng,
  }) {
    try {
      return Geolocator.distanceBetween(userLat, userLng, placeLat, placeLng);
    } catch (_) {
      return null;
    }
  }
}
