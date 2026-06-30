import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/map_route.dart';
import '../../domain/entities/navigation_profile.dart';

part 'map_navigation_state.freezed.dart';

@freezed
sealed class MapNavigationState with _$MapNavigationState {
  const MapNavigationState._();

  const factory MapNavigationState({
    @Default({}) Map<NavigationProfile, MapRoute> routesByProfile,
    @Default(false) bool isRouteLoading,
    String? routeError,
    @Default(NavigationProfile.driving) NavigationProfile selectedProfile,
    @Default(0) int currentStepIndex,
    @Default(0) int totalLegs,
    @Default(0) int currentLegIndex,
    @Default(false) bool isSequentialMode,
    String? destinationName,
    @Default([]) List<String> placeNames,
    double? remainingStepDistanceMeters,
  }) = _MapNavigationState;

  factory MapNavigationState.initial() => const MapNavigationState();

  MapRoute? get activeRoute => routesByProfile[selectedProfile];

  MapNavigationState clearActiveRoute() {
    final updatedRoutes = Map<NavigationProfile, MapRoute>.from(
      routesByProfile,
    );
    updatedRoutes.remove(selectedProfile);
    return copyWith(routesByProfile: updatedRoutes);
  }

  MapNavigationState clearAllRoutes() {
    return copyWith(routesByProfile: {});
  }

  MapNavigationState clearRouteError() {
    return copyWith(routeError: null);
  }

  String formatDurationFromSeconds(double seconds) {
    final totalMinutes = (seconds / 60).round();

    final days = totalMinutes ~/ 1440;
    final hours = (totalMinutes % 1440) ~/ 60;
    final mins = totalMinutes % 60;

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
