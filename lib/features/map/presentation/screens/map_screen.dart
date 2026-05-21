import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/features/map/Services/location_service/location_service_imp.dart';
import 'package:mindtrip/features/map/presentation/controllers/map_controller.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_cubit.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_navigation_cubit.dart';
import 'package:mindtrip/features/map/presentation/data/places_mock_data.dart';
import 'package:mindtrip/features/map/presentation/widgets/map_listener.dart';
import 'package:mindtrip/features/map/presentation/widgets/map_mark_relcoaiton_button.dart';
import 'package:mindtrip/features/map/presentation/widgets/map_relocate_button.dart';
import 'package:mindtrip/features/map/presentation/widgets/map_search_bar.dart';
import 'package:mindtrip/features/map/presentation/widgets/place_info_bottom_sheet.dart';
import 'package:mindtrip/features/map/domain/utils/distance_utils.dart';
import 'package:mindtrip/features/map/presentation/widgets/map_navigate_all_button.dart';

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

  Future<void> _navigateAll() async {
    final position = await sl<LocationService>().getCurrentLocation();
    if (mounted && position != null) {
      final userPosition = Position(position.longitude, position.latitude);
      final annotations = context.read<MapCubit>().state.annotations;
      final waypoints = [userPosition];

      final unvisited = List.of(annotations);
      var currentLat = position.latitude;
      var currentLng = position.longitude;

      while (unvisited.isNotEmpty) {
        final nearest = DistanceUtils.findNearestAnnotation(
          unvisited,
          currentLat,
          currentLng,
        );
        if (nearest != null) {
          waypoints.add(
            Position(
              nearest.place.location.longitude,
              nearest.place.location.latitude,
            ),
          );
          unvisited.remove(nearest);
          currentLat = nearest.place.location.latitude;
          currentLng = nearest.place.location.longitude;
        } else {
          break;
        }
      }

      context.read<MapNavigationCubit>().navigateAll(waypoints);
    }
  }

  Future<void> _onMapCreated(MapboxMap mapboxMap) async {
    await _mapController.init(mapboxMap);
    // await mapboxMap.loadStyleJson(myStyle);
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
      await _autoSelectNearestPlace();
    }
  }

  Future<void> _autoSelectNearestPlace() async {
    final annotations = context.read<MapCubit>().state.annotations;
    if (annotations.isEmpty) return;

    final position = await sl<LocationService>().getCurrentLocation();
    if (position != null && mounted) {
      final nearest = DistanceUtils.findNearestAnnotation(
        annotations,
        position.latitude,
        position.longitude,
      );
      if (nearest != null) {
        context.read<MapCubit>().selectPlace(nearest.place.id);
      }
    } else if (mounted) {
      context.read<MapCubit>().selectPlace(annotations.first.place.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final topSpace = MediaQuery.of(context).padding.top + 10.h;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: MapListener(
        mapController: _mapController,
        child: Stack(
          alignment: Alignment.center,
          children: [
            MapWidget(
              key: const ValueKey("mapWidget"),
              onMapCreated: _onMapCreated,
              styleUri: 'mapbox://styles/xmohamedx/cmpc4uw4g00a901s75avq3q3a',
            ),
            Positioned(top: topSpace, child: const MapSearchBar()),
            Positioned(
              bottom: 120,
              right: 16,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (context.watch<MapCubit>().state.annotations.isNotEmpty) ...[
                    MapNavigateAllButton(onPressed: _navigateAll),
                    SizedBox(height: 16.h),
                  ],
                  MapMarkRelcoaitonButton(
                    onTap: () => _mapController.fitToAnnotations(),
                  ),
                  SizedBox(height: 16.h),
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
