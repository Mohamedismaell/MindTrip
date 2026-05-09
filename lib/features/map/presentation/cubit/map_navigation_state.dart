import 'package:equatable/equatable.dart';
import '../../domain/entities/map_route.dart';
import '../../domain/entities/navigation_profile.dart';

class MapNavigationState extends Equatable {
  final MapRoute? activeRoute;
  final bool isRouteLoading;
  final String? routeError;
  final NavigationProfile selectedProfile;
  final int currentStepIndex;

  const MapNavigationState({
    this.activeRoute,
    required this.isRouteLoading,
    this.routeError,
    required this.selectedProfile,
    required this.currentStepIndex,
  });

  factory MapNavigationState.initial() => const MapNavigationState(
    activeRoute: null,
    isRouteLoading: false,
    routeError: null,
    selectedProfile: NavigationProfile.driving,
    currentStepIndex: 0,
  );

  MapNavigationState copyWith({
    MapRoute? activeRoute,
    bool clearActiveRoute = false,
    bool? isRouteLoading,
    String? routeError,
    bool clearRouteError = false,
    NavigationProfile? selectedProfile,
    int? currentStepIndex,
  }) {
    return MapNavigationState(
      activeRoute: clearActiveRoute ? null : (activeRoute ?? this.activeRoute),
      isRouteLoading: isRouteLoading ?? this.isRouteLoading,
      routeError: clearRouteError ? null : (routeError ?? this.routeError),
      selectedProfile: selectedProfile ?? this.selectedProfile,
      currentStepIndex: currentStepIndex ?? this.currentStepIndex,
    );
  }

  @override
  List<Object?> get props => [
    activeRoute,
    isRouteLoading,
    routeError,
    selectedProfile,
    currentStepIndex,
  ];
}
