import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/features/map/presentation/controllers/map_controller.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_cubit.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_navigation_cubit.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_navigation_state.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_search_cubit.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_search_state.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_state.dart';

class MapListener extends StatelessWidget {
  const MapListener({
    super.key,
    required this.child,
    required MapController mapController,
  }) : _mapController = mapController;
  final MapController _mapController;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MapNavigationCubit, MapNavigationState>(
          listenWhen: (prev, curr) => prev.activeRoute != curr.activeRoute,
          listener: (context, state) async {
            if (state.activeRoute != null) {
              await _mapController.drawRoute(
                state.activeRoute!.geoJsonGeometry,
                congestionLevels: state.activeRoute!.congestionLevels,
              );
            } else {
              await _mapController.clearRoute();
            }
          },
        ),
        BlocListener<MapSearchCubit, MapSearchState>(
          listenWhen: (prev, curr) =>
              prev.resolvedSearchPlace != curr.resolvedSearchPlace &&
              curr.resolvedSearchPlace != null,
          listener: (context, state) async {
            final result = state.resolvedSearchPlace!;
            if (result.latitude != null && result.longitude != null) {
              await _mapController.addSearchResultMarker(
                result.latitude!,
                result.longitude!,
                place: result,
              );
              await _mapController.flyTo(result.latitude!, result.longitude!);
            }

            if (context.mounted) {
              context.read<MapCubit>().showGooglePlaceDetails(result);
              context.read<MapSearchCubit>().clearResolvedSearchResult();
            }
          },
        ),
        BlocListener<MapCubit, MapState>(
          listenWhen: (prev, curr) =>
              prev.flyToLat != curr.flyToLat &&
              curr.flyToLat != null &&
              curr.flyToLng != null,
          listener: (context, state) async {
            await _mapController.flyTo(state.flyToLat!, state.flyToLng!);
            if (context.mounted) {
              context.read<MapCubit>().clearFlyToLocation();
            }
          },
        ),
        BlocListener<MapSearchCubit, MapSearchState>(
          listenWhen: (prev, curr) => prev.nearbyPlaces != curr.nearbyPlaces,
          listener: (context, state) async {
            if (state.nearbyPlaces.isNotEmpty) {
              await _mapController.addGooglePlaceAnnotations(
                state.nearbyPlaces,
              );
            }
          },
        ),
      ],
      child: child,
    );
  }
}
