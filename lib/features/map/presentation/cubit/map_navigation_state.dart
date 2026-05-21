import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/map_route.dart';
import '../../domain/entities/navigation_profile.dart';

part 'map_navigation_state.freezed.dart';

@freezed
sealed class MapNavigationState with _$MapNavigationState {
  const MapNavigationState._();

  const factory MapNavigationState({
    MapRoute? activeRoute,

    @Default(false) bool isRouteLoading,

    String? routeError,

    @Default(NavigationProfile.driving) NavigationProfile selectedProfile,

    @Default(0) int currentStepIndex,

    @Default(0) int totalLegs,

    @Default(0) int currentLegIndex,

    @Default(false) bool isSequentialMode,
  }) = _MapNavigationState;

  factory MapNavigationState.initial() => const MapNavigationState();

  MapNavigationState clearActiveRoute() {
    return copyWith(activeRoute: null);
  }

  MapNavigationState clearRouteError() {
    return copyWith(routeError: null);
  }
}
