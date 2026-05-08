import 'package:equatable/equatable.dart';
import '../../domain/entities/map_route.dart';

class MapNavigationState extends Equatable {
  final MapRoute? activeRoute;
  final bool isRouteLoading;
  final String? routeError;

  const MapNavigationState({
    this.activeRoute,
    required this.isRouteLoading,
    this.routeError,
  });

  factory MapNavigationState.initial() => const MapNavigationState(
        activeRoute: null,
        isRouteLoading: false,
        routeError: null,
      );

  MapNavigationState copyWith({
    MapRoute? activeRoute,
    bool clearActiveRoute = false,
    bool? isRouteLoading,
    String? routeError,
    bool clearRouteError = false,
  }) {
    return MapNavigationState(
      activeRoute: clearActiveRoute ? null : (activeRoute ?? this.activeRoute),
      isRouteLoading: isRouteLoading ?? this.isRouteLoading,
      routeError: clearRouteError ? null : (routeError ?? this.routeError),
    );
  }

  @override
  List<Object?> get props => [
        activeRoute,
        isRouteLoading,
        routeError,
      ];
}
