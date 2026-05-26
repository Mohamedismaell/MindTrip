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

    String? destinationName,

    @Default([]) List<String> placeNames,
  }) = _MapNavigationState;

  factory MapNavigationState.initial() => const MapNavigationState();

  MapNavigationState clearActiveRoute() {
    return copyWith(activeRoute: null);
  }

  MapNavigationState clearRouteError() {
    return copyWith(routeError: null);
  }

  String formatDuration(int minutes) {
    final days = minutes ~/ 1440;
    final hours = (minutes % 1440) ~/ 60;
    final mins = minutes % 60;

    if (days > 0) {
      if (hours > 0) return '${days}d ${hours}h';
      return '${days}d';
    }

    if (hours > 0) {
      if (mins > 0) return '${hours}h ${mins}m';
      return '${hours}h';
    }

    return '${mins}m';
  }

  String formatDistance(double meters) {
    if (meters < 1000) {
      return '${meters.toInt()} m';
    }

    final km = meters / 1000;

    if (km < 10) {
      return '${km.toStringAsFixed(1)} km';
    }

    return '${km.toStringAsFixed(0)} km';
  }
}
