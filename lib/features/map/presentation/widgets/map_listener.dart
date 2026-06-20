import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/features/map/presentation/controllers/map_controller.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_cubit.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_navigation_cubit.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_navigation_state.dart';
import 'package:mindtrip/features/map/presentation/bloc/map_search_bloc.dart';
import 'package:mindtrip/features/map/presentation/bloc/map_search_event.dart';
import 'package:mindtrip/features/map/presentation/bloc/map_search_state.dart';
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
        //  Route draw
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

        //  Search result resolved → show on map
        BlocListener<MapSearchBloc, MapSearchState>(
          listenWhen: (prev, curr) =>
              prev.resolvedSearchPlace != curr.resolvedSearchPlace &&
              curr.resolvedSearchPlace != null,
          listener: (context, state) async {
            final result = state.resolvedSearchPlace!;
            if (context.mounted) {
              context.read<MapCubit>().showGooglePlaceDetails(result);
              context
                  .read<MapSearchBloc>()
                  .add(const ClearResolvedPlace());
            }
          },
        ),

        //  FlyTo trigger (pulse-based)
        BlocListener<MapCubit, MapState>(
          listenWhen: (prev, curr) => prev.flyToPulse != curr.flyToPulse,
          listener: (context, state) async {
            if (state.flyToLat != null && state.flyToLng != null) {
              await _mapController.flyTo(state.flyToLat!, state.flyToLng!);
              if (context.mounted) {
                context.read<MapCubit>().clearFlyToLocation();
              }
            }
          },
        ),

        //  Nearby places pins
        BlocListener<MapSearchBloc, MapSearchState>(
          listenWhen: (prev, curr) => prev.nearbyPlaces != curr.nearbyPlaces,
          listener: (context, state) async {
            if (state.nearbyPlaces.isNotEmpty) {
              await _mapController.addGooglePlaceAnnotations(
                state.nearbyPlaces,
              );
            }
          },
        ),

        //  Annotations changed (day switch || place load)
        BlocListener<MapCubit, MapState>(
          listenWhen: (prev, curr) => prev.annotations != curr.annotations,
          listener: (context, state) async {
            await _mapController.clearRoute();
            if (state.annotations.isNotEmpty) {
              await _mapController.addPlaceAnnotations(state.annotations);
              await _mapController.fitToAnnotations();
            } else {
              await _mapController.clearPlaceAnnotations();
            }
          },
        ),
      ],
      child: child,
    );
  }
}
