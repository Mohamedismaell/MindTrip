import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/features/map/Services/location_service/location_service.dart';
import 'package:mindtrip/features/map/Services/location_service/location_service_imp.dart';

class MapDi {
  MapDi._();

  static void init() {
    sl.registerLazySingleton<LocationService>(() => LocationServiceImp());
  }
}
