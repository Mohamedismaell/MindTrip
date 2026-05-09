import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import '../../domain/entities/navigation_profile.dart';
import '../../domain/repositories/map_route_repository.dart';
import 'map_navigation_state.dart';

class MapNavigationCubit extends Cubit<MapNavigationState> {
  final MapRouteRepository routeRepo;

  /// Stores the last requested waypoints so we can re-fetch on profile change
  List<Position>? _lastWaypoints;

  MapNavigationCubit({required this.routeRepo})
      : super(MapNavigationState.initial());

  void setProfile(NavigationProfile profile) {
    emit(state.copyWith(selectedProfile: profile, currentStepIndex: 0));

    // Re-fetch route with new profile if a route is active
    if (_lastWaypoints != null && _lastWaypoints!.isNotEmpty) {
      _fetchRoute(_lastWaypoints!);
    }
  }

  Future<void> navigateToPosition(
      Position userPosition, double lat, double lng) async {
    final placePosition = Position(lng, lat);
    await _fetchRoute([userPosition, placePosition]);
  }

  Future<void> navigateAll(List<Position> waypoints) async {
    await _fetchRoute(waypoints);
  }

  Future<void> _fetchRoute(List<Position> waypoints) async {
    _lastWaypoints = waypoints;
    emit(state.copyWith(
      isRouteLoading: true,
      clearRouteError: true,
      currentStepIndex: 0,
    ));

    final result = await routeRepo.getRoute(
      waypoints,
      profile: state.selectedProfile,
    );

    result.when(
      success: (route) {
        emit(state.copyWith(isRouteLoading: false, activeRoute: route));
      },
      failure: (error) {
        emit(state.copyWith(isRouteLoading: false, routeError: error.message));
      },
    );
  }

  void stopNavigation() {
    _lastWaypoints = null;
    emit(state.copyWith(
      clearActiveRoute: true,
      clearRouteError: true,
      isRouteLoading: false,
      currentStepIndex: 0,
    ));
  }
}
