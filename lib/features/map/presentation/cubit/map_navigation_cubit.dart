import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:mindtrip/core/errors/failure/failure.dart';
import 'package:mindtrip/features/map/domain/use_cases/get_route_use_case.dart';
import '../../domain/entities/navigation_profile.dart';
import 'map_navigation_state.dart';

class MapNavigationCubit extends Cubit<MapNavigationState> {
  final GetRouteUseCase _getRouteUseCase;

  List<Position>? _lastWaypoints;
  CancelToken? _getRouteCancelToken;
  int _routeGeneration = 0;

  MapNavigationCubit({required GetRouteUseCase getRouteUseCase})
    : _getRouteUseCase = getRouteUseCase,
      super(MapNavigationState.initial());

  CancelToken _getRouteToken() {
    _getRouteCancelToken?.cancel();
    _getRouteCancelToken = CancelToken();
    return _getRouteCancelToken!;
  }

  void setProfile(NavigationProfile profile) {
    emit(state.copyWith(selectedProfile: profile, currentStepIndex: 0));

    if (_lastWaypoints != null && _lastWaypoints!.isNotEmpty) {
      _fetchRoute(_lastWaypoints!);
    }
  }

  Future<void> navigateToPosition(
    Position userPosition,
    double lat,
    double lng,
  ) async {
    final placePosition = Position(lng, lat);
    await _fetchRoute([userPosition, placePosition]);
  }

  Future<void> navigateAll(List<Position> waypoints) async {
    await _fetchRoute(waypoints);
  }

  Future<void> _fetchRoute(List<Position> waypoints) async {
    final token = _getRouteToken();
    _lastWaypoints = waypoints;
    final generation = ++_routeGeneration;

    emit(state.copyWith(isRouteLoading: true, currentStepIndex: 0));

    final result = await _getRouteUseCase.call(
      waypoints,
      profile: state.selectedProfile,
      cancelToken: token,
    );

    // A newer request was fired while this one was in flight → ignore result
    if (generation != _routeGeneration) return;

    result.when(
      success: (route) {
        if (!isClosed) {
          emit(state.copyWith(isRouteLoading: false, activeRoute: route));
        }
      },
      failure: (failure) {
        if (!isClosed && failure is! CancelledFailure) {
          emit(
            state.copyWith(isRouteLoading: false, routeError: failure.message),
          );
        }
      },
    );
  }

  void stopNavigation() {
    _lastWaypoints = null;
    _routeGeneration++; // Invalidate any in-flight request
    _getRouteCancelToken?.cancel();
    emit(state.copyWith(isRouteLoading: false, currentStepIndex: 0));
  }

  @override
  Future<void> close() {
    _getRouteCancelToken?.cancel();
    return super.close();
  }
}
