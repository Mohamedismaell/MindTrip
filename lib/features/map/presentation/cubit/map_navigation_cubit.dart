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
  List<Position>? _sequentialWaypoints;
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
    await navigateSequential(waypoints);
  }

  Future<void> navigateSequential(List<Position> waypoints) async {
    if (waypoints.length < 2) return;
    _sequentialWaypoints = waypoints;
    emit(
      state.copyWith(
        isSequentialMode: true,
        totalLegs: waypoints.length - 1,
        currentLegIndex: 0,
      ),
    );
    await _fetchSequentialLegRoute(0);
  }

  Future<void> advanceToNextLeg() async {
    if (_sequentialWaypoints == null || !state.isSequentialMode) return;
    final nextLeg = state.currentLegIndex + 1;
    if (nextLeg >= state.totalLegs) {
      stopNavigation();
      return;
    }
    emit(state.copyWith(currentLegIndex: nextLeg));
    await _fetchSequentialLegRoute(nextLeg);
  }

  Future<void> _fetchSequentialLegRoute(int legIndex) async {
    if (_sequentialWaypoints == null) return;
    final start = _sequentialWaypoints![legIndex];
    final end = _sequentialWaypoints![legIndex + 1];

    // Call _fetchRoute for leg
    await _fetchRoute([start, end]);
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
    _sequentialWaypoints = null;
    _routeGeneration++; // Invalidate any in-flight request
    _getRouteCancelToken?.cancel();
    emit(
      state.copyWith(
        isRouteLoading: false,
        currentStepIndex: 0,
        isSequentialMode: false,
        currentLegIndex: 0,
        totalLegs: 0,
        activeRoute: null,
      ),
    );
  }

  @override
  Future<void> close() {
    _getRouteCancelToken?.cancel();
    return super.close();
  }
}
