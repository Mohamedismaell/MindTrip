import 'package:geolocator/geolocator.dart';
import 'package:mindtrip/features/map/Services/location_service/location_service.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationServiceImp implements LocationService {
  @override
  Future<bool> requestPermission() async {
    final status = await Permission.location.request();
    return status.isGranted;
  }

  @override
  Future<bool> isServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  @override
  Future<Position?> getCurrentLocation() async {
    try {
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
