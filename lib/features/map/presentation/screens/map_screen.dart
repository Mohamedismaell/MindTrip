import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/features/map/Services/location_service/location_service_imp.dart';
import 'package:mindtrip/features/map/presentation/controllers/map_controller.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_cubit.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_state.dart';
import 'package:mindtrip/features/map/presentation/data/places_mock_data.dart';
import 'package:mindtrip/features/map/presentation/widgets/map_mark_relcoaiton_button.dart';
import 'package:mindtrip/features/map/presentation/widgets/map_relocate_button.dart';
import 'package:mindtrip/features/map/presentation/widgets/map_search_bar.dart';
import 'package:mindtrip/features/map/presentation/widgets/place_info_bottom_sheet.dart';

//Todo: handle bottom sheet to show on tap known places from mock or from search later try to handle on tap poe for general if possible
//! on Tap not Working
//Todo: add navigation route between the places and the other functionallity
//Todo: fix the resolution of the marks plater
class MapScreen extends StatefulWidget {
  final List<PlaceModel> places;

  const MapScreen({super.key, this.places = PlacesMockData.mockPlaces});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    context.read<MapCubit>().loadPlaces(widget.places);
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  Future<void> _relocateUser() async {
    final position = await sl<LocationService>().getCurrentLocation();
    if (mounted && position != null) {
      await _mapController.flyTo(position.latitude, position.longitude);
    }
  }

  Future<void> _onMapCreated(MapboxMap mapboxMap) async {
    await _mapController.init(mapboxMap);

    _mapController.setupAnnotationTapHandler(
      onPlaceTap: (placeId) {
        if (mounted) context.read<MapCubit>().selectPlace(placeId);
      },
      onGooglePlaceTap: (place) {
        if (mounted) context.read<MapCubit>().showGooglePlaceDetails(place);
      },
    );

    if (mounted) {
      final entries = context.read<MapCubit>().state.annotations;
      await _mapController.addPlaceAnnotations(entries);
      await _mapController.fitToAnnotations();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: MultiBlocListener(
        listeners: [
          BlocListener<MapCubit, MapState>(
            listenWhen: (prev, curr) => prev.activeRoute != curr.activeRoute,
            listener: (context, state) async {
              if (state.activeRoute != null) {
                await _mapController.drawRoute(
                  state.activeRoute!.geoJsonGeometry,
                );
              } else {
                await _mapController.clearRoute();
              }
            },
          ),
          BlocListener<MapCubit, MapState>(
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
                context.read<MapCubit>().clearResolvedSearchResult();
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
          BlocListener<MapCubit, MapState>(
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
        child: Stack(
          alignment: Alignment.center,
          children: [
            MapWidget(
              key: const ValueKey("mapWidget"),
              onMapCreated: _onMapCreated,
              styleUri: "mapbox://styles/mapbox/outdoors-v12",
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top + 10,
              child: const MapSearchBar(),
            ),
            Positioned(
              bottom: 120,
              right: 16,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MapMarkRelcoaitonButton(
                    onTap: () => _mapController.fitToAnnotations(),
                  ),
                  const SizedBox(height: 16),
                  MapRelocateButton(onPressed: _relocateUser),
                ],
              ),
            ),
            const PlaceInfoBottomSheet(),
          ],
        ),
      ),
    );
  }
}
