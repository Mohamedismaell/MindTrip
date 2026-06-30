import 'dart:async';

import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mapbox;
import 'package:mindtrip/core/shared/presentation/bloc/safe_cubit.dart';
import 'package:mindtrip/features/map/Services/location_service/location_service_imp.dart';
import 'package:mindtrip/features/map/domain/entities/map_route.dart';
import 'package:mindtrip/features/map/domain/entities/route_step.dart';
import 'package:mindtrip/features/map/domain/use_cases/get_route_use_case.dart';

import '../../domain/entities/navigation_profile.dart';
import 'map_navigation_state.dart';

class MapNavigationCubit extends SafeCubit<MapNavigationState> {
  final GetRouteUseCase _getRouteUseCase;
  final LocationService _locationService;

  List<mapbox.Position>? _lastWaypoints;
  List<mapbox.Position>? _sequentialWaypoints;
  CancelToken? _getRouteCancelToken;
  StreamSubscription<geo.Position>? _positionSubscription;

  int _routeGeneration = 0;
  bool _isRerouting = false;

  MapNavigationCubit({
    required GetRouteUseCase getRouteUseCase,
    required LocationService locationService,
  }) : _getRouteUseCase = getRouteUseCase,
       _locationService = locationService,
       super(MapNavigationState.initial());

  CancelToken _getRouteToken() {
    _getRouteCancelToken?.cancel();
    _getRouteCancelToken = CancelToken();
    return _getRouteCancelToken!;
  }

  void beginLoading({String? destinationName}) {
    emitSafe(
      state.copyWith(
        isRouteLoading: true,
        routeError: null,
        destinationName: destinationName,
      ),
    );
  }

  Future<void> setProfile(NavigationProfile profile) async {
    emitSafe(
      state.copyWith(
        selectedProfile: profile,
        currentStepIndex: 0,
        routeError: null,
        remainingStepDistanceMeters: null,
      ),
    );

    final cachedRoute = state.routesByProfile[profile];
    if (cachedRoute != null) {
      await _refreshRemainingDistanceFromCurrentLocation();
      return;
    }

    if (_lastWaypoints != null && _lastWaypoints!.isNotEmpty) {
      await _fetchRoute(_lastWaypoints!, profile: profile);
    }
  }

  Future<void> navigateToPosition(
    mapbox.Position userPosition,
    double lat,
    double lng, {
    String? destinationName,
  }) async {
    emitSafe(
      state.copyWith(
        destinationName: destinationName,
        isRouteLoading: true,
        routeError: null,
        currentStepIndex: 0,
        remainingStepDistanceMeters: null,
      ),
    );

    final placePosition = mapbox.Position(lng, lat);
    await _fetchRoute([
      userPosition,
      placePosition,
    ], profile: state.selectedProfile);
  }

  Future<void> navigateAll(
    List<mapbox.Position> waypoints,
    List<String> placeNames,
  ) async {
    await navigateSequential(waypoints, placeNames);
  }

  Future<void> navigateSequential(
    List<mapbox.Position> waypoints,
    List<String> placeNames,
  ) async {
    if (waypoints.length < 2) return;

    _sequentialWaypoints = waypoints;

    emitSafe(
      state.copyWith(
        isSequentialMode: true,
        isRouteLoading: true,
        totalLegs: waypoints.length - 1,
        currentLegIndex: 0,
        currentStepIndex: 0,
        placeNames: placeNames,
        destinationName: placeNames.isNotEmpty ? placeNames.first : null,
        routeError: null,
        routesByProfile: {},
        remainingStepDistanceMeters: null,
      ),
    );

    await _fetchSequentialLegRoute(0, profile: state.selectedProfile);
  }

  Future<void> advanceToNextLeg() async {
    if (_sequentialWaypoints == null || !state.isSequentialMode) return;

    final nextLeg = state.currentLegIndex + 1;
    if (nextLeg >= state.totalLegs) {
      stopNavigation();
      return;
    }

    emitSafe(
      state.copyWith(
        currentLegIndex: nextLeg,
        currentStepIndex: 0,
        destinationName: nextLeg < state.placeNames.length
            ? state.placeNames[nextLeg]
            : null,
        routesByProfile: {},
        routeError: null,
        remainingStepDistanceMeters: null,
      ),
    );

    await _fetchSequentialLegRoute(nextLeg, profile: state.selectedProfile);
  }

  Future<void> _fetchSequentialLegRoute(
    int legIndex, {
    required NavigationProfile profile,
  }) async {
    if (_sequentialWaypoints == null) return;

    final end = _sequentialWaypoints![legIndex + 1];

    final pos = await _locationService.getCurrentLocation();
    final start = pos != null
        ? mapbox.Position(pos.longitude, pos.latitude)
        : _sequentialWaypoints![legIndex];

    await _fetchRoute([start, end], profile: profile);
  }

  Future<void> _fetchRoute(
    List<mapbox.Position> waypoints, {
    NavigationProfile? profile,
  }) async {
    final effectiveProfile = profile ?? state.selectedProfile;
    final token = _getRouteToken();

    _lastWaypoints = waypoints;
    final generation = ++_routeGeneration;

    emitSafe(
      state.copyWith(
        isRouteLoading: true,
        currentStepIndex: 0,
        routeError: null,
        remainingStepDistanceMeters: null,
      ),
    );

    final result = await _getRouteUseCase.call(
      waypoints,
      profile: effectiveProfile,
      cancelToken: token,
    );

    if (generation != _routeGeneration) return;

    result.when(
      success: (route) async {
        final updatedRoutes = Map<NavigationProfile, MapRoute>.from(
          state.routesByProfile,
        );
        updatedRoutes[effectiveProfile] = route;

        emitSafe(
          state.copyWith(
            isRouteLoading: false,
            routesByProfile: updatedRoutes,
            routeError: null,
            remainingStepDistanceMeters: null,
          ),
        );

        if (effectiveProfile == state.selectedProfile) {
          await _startLocationTracking();
          await _refreshRemainingDistanceFromCurrentLocation();
        }
      },
      failure: (failure) {
        emitSafe(
          state.copyWith(isRouteLoading: false, routeError: failure.message),
        );
      },
      cancelled: () {},
    );
  }

  Future<void> _startLocationTracking() async {
    _positionSubscription?.cancel();

    final access = await _locationService.checkAccess();
    if (access != LocationAccessStatus.granted) return;

    _positionSubscription = _locationService
        .getPositionStream(
          accuracy: geo.LocationAccuracy.bestForNavigation,
          distanceFilter: 8,
        )
        .listen((position) async {
          await _handleLivePosition(position);
        });
  }

  Future<void> _refreshRemainingDistanceFromCurrentLocation() async {
    final currentPosition = await _locationService.getCurrentLocation();
    if (currentPosition == null) return;

    await _handleLivePosition(currentPosition);
  }

  Future<void> _handleLivePosition(geo.Position position) async {
    final route = state.activeRoute;
    if (route == null || state.isRouteLoading) return;

    final steps = route.allSteps;
    if (steps.isEmpty) return;

    final nextStepIndex = _resolveStepIndex(
      steps: steps,
      currentIndex: state.currentStepIndex,
      userLat: position.latitude,
      userLng: position.longitude,
    );

    final currentStep = steps[nextStepIndex];
    final remainingDistance = _distanceToStep(
      step: currentStep,
      userLat: position.latitude,
      userLng: position.longitude,
    );

    final previousDistance = state.remainingStepDistanceMeters;
    final distanceChanged =
        previousDistance == null ||
        remainingDistance == null ||
        (previousDistance - remainingDistance).abs() >= 3;

    final shouldEmit =
        nextStepIndex != state.currentStepIndex || distanceChanged;

    if (shouldEmit) {
      emitSafe(
        state.copyWith(
          currentStepIndex: nextStepIndex,
          remainingStepDistanceMeters: remainingDistance,
        ),
      );
    }

    await _checkArrivalOrReroute(position, route);
  }

  int _resolveStepIndex({
    required List<RouteStep> steps,
    required int currentIndex,
    required double userLat,
    required double userLng,
  }) {
    if (steps.isEmpty) return 0;

    final safeCurrentIndex = currentIndex.clamp(0, steps.length - 1);

    if (safeCurrentIndex >= steps.length - 1) {
      return safeCurrentIndex;
    }

    final currentStep = steps[safeCurrentIndex];
    final nextStep = steps[safeCurrentIndex + 1];

    final currentDistance = _distanceToStep(
      step: currentStep,
      userLat: userLat,
      userLng: userLng,
    );

    final nextDistance = _distanceToStep(
      step: nextStep,
      userLat: userLat,
      userLng: userLng,
    );

    if (nextDistance != null && nextDistance < 30) {
      return safeCurrentIndex + 1;
    }

    if (currentDistance != null &&
        nextDistance != null &&
        nextDistance + 12 < currentDistance) {
      return safeCurrentIndex + 1;
    }

    return safeCurrentIndex;
  }

  double? _distanceToStep({
    required RouteStep step,
    required double userLat,
    required double userLng,
  }) {
    final location = step.maneuverLocation;
    if (location == null) return null;

    return _locationService.getDistanceBetween(
      userLat: userLat,
      userLng: userLng,
      placeLat: location.lat.toDouble(),
      placeLng: location.lng.toDouble(),
    );
  }

  Future<void> _checkArrivalOrReroute(
    geo.Position position,
    MapRoute route,
  ) async {
    final destination = route.waypoints.isNotEmpty
        ? route.waypoints.last
        : null;
    if (destination == null) return;

    final destinationDistance = _locationService.getDistanceBetween(
      userLat: position.latitude,
      userLng: position.longitude,
      placeLat: destination.lat.toDouble(),
      placeLng: destination.lng.toDouble(),
    );

    if (destinationDistance != null && destinationDistance < 30) {
      if (state.isSequentialMode) {
        await advanceToNextLeg();
      }
      return;
    }

    if (!state.isSequentialMode || _isRerouting) return;
    if (_lastWaypoints == null || _lastWaypoints!.length < 2) return;

    final routeStart = _lastWaypoints!.first;
    final distanceFromStart = _locationService.getDistanceBetween(
      userLat: position.latitude,
      userLng: position.longitude,
      placeLat: routeStart.lat.toDouble(),
      placeLng: routeStart.lng.toDouble(),
    );

    if (distanceFromStart != null && distanceFromStart > 120) {
      _isRerouting = true;
      try {
        await _fetchSequentialLegRoute(
          state.currentLegIndex,
          profile: state.selectedProfile,
        );
      } finally {
        _isRerouting = false;
      }
    }
  }

  void stopNavigation() {
    _lastWaypoints = null;
    _sequentialWaypoints = null;
    _routeGeneration++;
    _getRouteCancelToken?.cancel();
    _positionSubscription?.cancel();
    _positionSubscription = null;
    _isRerouting = false;

    emitSafe(
      state.copyWith(
        isRouteLoading: false,
        currentStepIndex: 0,
        isSequentialMode: false,
        currentLegIndex: 0,
        totalLegs: 0,
        destinationName: null,
        placeNames: [],
        routeError: null,
        routesByProfile: {},
        remainingStepDistanceMeters: null,
      ),
    );
  }

  @override
  Future<void> close() {
    _getRouteCancelToken?.cancel();
    _positionSubscription?.cancel();
    return super.close();
  }
}
