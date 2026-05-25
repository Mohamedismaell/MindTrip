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

    /// Name of the place being navigated to
    String? destinationName,

    /// All place names in sequential navigation order
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
    if (minutes < 60) {
      return '$minutes min';
    }

    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;

    if (remainingMinutes == 0) {
      return '$hours hr';
    }

    if (remainingMinutes < 10) {
      return '$hours hr $remainingMinutes min';
    }

    return '$hours:${remainingMinutes.toString().padLeft(2, '0')} hr';
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
