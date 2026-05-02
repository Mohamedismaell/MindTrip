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
import 'package:mindtrip/features/map/presentation/widgets/map_relocate_button.dart';
import 'package:mindtrip/features/map/presentation/widgets/map_search_bar.dart';
import 'package:mindtrip/features/map/presentation/widgets/place_info_bottom_sheet.dart';

// // Todo: edit marks image to be without background and edit the size if needed current is to big
//Todo: fix the resolution of the marks plater
//Todo: make map screen deafut range of the selected places location and add button for this trip camera flow
//Todo: handle bottom sheet to show on tap known places from mock or from search later try to handle on tap poe for general if possible
//Todo: add navigation route between the places and the other functionallity
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
    // final position = await sl<LocationService>().getCurrentLocation();

    // final userPos = position != null
    //     ? Position(position.longitude, position.latitude)
    //     : Position(0, 0);

    // await _mapController.init(mapboxMap, userPos);
    await _mapController.init(mapboxMap);

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
                prev.resolvedSearchResult != curr.resolvedSearchResult &&
                curr.resolvedSearchResult != null,
            listener: (context, state) async {
              final result = state.resolvedSearchResult!;
              await _mapController.addSearchResultMarker(
                result.latitude,
                result.longitude,
              );
              await _mapController.flyTo(result.latitude, result.longitude);

              if (context.mounted) {
                context.read<MapCubit>().clearResolvedSearchResult();
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
                  GestureDetector(
                    onTap: () => _mapController.fitToAnnotations(),
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.fit_screen_rounded,
                        color: Theme.of(context).colorScheme.primary,
                        size: 28,
                      ),
                    ),
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
