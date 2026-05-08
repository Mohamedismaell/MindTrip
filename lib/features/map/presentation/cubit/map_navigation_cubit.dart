import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import '../../domain/repositories/map_route_repository.dart';
import 'map_navigation_state.dart';

class MapNavigationCubit extends Cubit<MapNavigationState> {
  final MapRouteRepository routeRepo;

  MapNavigationCubit({required this.routeRepo})
      : super(MapNavigationState.initial());

  Future<void> navigateToPosition(
      Position userPosition, double lat, double lng) async {
    final placePosition = Position(lng, lat);
    await _fetchRoute([userPosition, placePosition]);
  }

  Future<void> navigateAll(List<Position> waypoints) async {
    await _fetchRoute(waypoints);
  }

  Future<void> _fetchRoute(List<Position> waypoints) async {
    emit(state.copyWith(isRouteLoading: true, clearRouteError: true));
    final result = await routeRepo.getRoute(waypoints);

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
    emit(state.copyWith(
      clearActiveRoute: true,
      clearRouteError: true,
      isRouteLoading: false,
    ));
  }
}
