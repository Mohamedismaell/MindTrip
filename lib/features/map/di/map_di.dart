import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/location/cubit/location_cubit.dart';
import 'package:mindtrip/features/map/Services/location_service/location_service_imp.dart';

class MapDi {
  MapDi._();

  static void init() {
    sl.registerLazySingleton<LocationService>(() => LocationServiceImp());
    sl.registerLazySingleton<LocationCubit>(
      () => LocationCubit(locationService: sl<LocationService>()),
    );
  }
}
