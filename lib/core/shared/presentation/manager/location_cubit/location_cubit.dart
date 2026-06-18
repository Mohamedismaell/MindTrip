import 'package:bloc/bloc.dart';
import 'package:mindtrip/core/shared/presentation/manager/location_cubit/location_state.dart';
import 'package:mindtrip/features/map/Services/location_service/location_service_imp.dart';

class LocationCubit extends Cubit<LocationState> {
  final LocationService _locationService;

  LocationCubit({required LocationService locationService})
    : _locationService = locationService,
      super(const LocationState());

  Future<void> requestAndFetchLocation() async {
    emit(state.copyWith(status: LocationStatus.loading));

    final accessStatus = await _locationService.checkAccess();

    switch (accessStatus) {
      case LocationAccessStatus.denied:
        emit(state.copyWith(status: LocationStatus.denied));
        return;

      case LocationAccessStatus.deniedForever:
        emit(state.copyWith(status: LocationStatus.deniedForever));
        return;

      case LocationAccessStatus.serviceDisabled:
        emit(state.copyWith(status: LocationStatus.serviceDisabled));
        return;

      case LocationAccessStatus.granted:
        emit(state.copyWith(status: LocationStatus.granted));
        await _fetchCurrentLocation();
        break;
    }
  }

  Future<void> retry() async => requestAndFetchLocation();

  Future<void> _fetchCurrentLocation() async {
    final result = await _locationService.getCurrentLocationDetails();
    if (result != null) {
      emit(state.copyWith(location: result));
    } else {
      emit(state.copyWith(status: LocationStatus.error));
    }
  }

  double? getDistanceBetween({
    required double placeLat,
    required double placeLng,
  }) {
    if (state.location == null) {
      return null;
    }
    return _locationService.getDistanceBetween(
      userLat: state.location!.latitude,
      userLng: state.location!.longitude,
      placeLat: placeLat,
      placeLng: placeLng,
    );
  }
}
