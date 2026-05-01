import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/features/map/Services/location_service/location_service_imp.dart';
import 'package:mindtrip/features/map/domain/entities/place_category.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_cubit.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_state.dart';
import 'package:mindtrip/features/map/presentation/widgets/map_marker_painter.dart';
import 'package:mindtrip/features/map/presentation/widgets/map_search_bar.dart';
import 'package:mindtrip/features/map/presentation/widgets/map_navigation_bar.dart';
import 'package:mindtrip/features/map/presentation/widgets/map_relocate_button.dart';
import 'package:mindtrip/features/map/presentation/widgets/place_info_bottom_sheet.dart';

class MapScreen extends StatefulWidget {
  final List<PlaceModel> places;

  const MapScreen({super.key, this.places = const []});
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapboxMap? mapboxMap;
  PointAnnotationManager? pointAnnotationManager;
  PolylineAnnotationManager? polylineAnnotationManager;
  bool _annotationsDrawn = false;
  final Map<String, String> _annotationIdToPlaceId = {};

  @override
  void initState() {
    context.read<MapCubit>().loadPlaces(widget.places);

    super.initState();
  }

  Future<void> _relocateUser() async {
    final locationService = sl<LocationService>();
    final position = await locationService.getCurrentLocation();

    if (mounted && position != null && mapboxMap != null) {
      mapboxMap!.flyTo(
        CameraOptions(
          center: Point(
            coordinates: Position(position.longitude, position.latitude),
          ),
          zoom: 15,
        ),
        MapAnimationOptions(duration: 1500),
      );
    }
  }

  Future<void> _onMapCreated(MapboxMap mapboxMap) async {
    this.mapboxMap = mapboxMap;
    mapboxMap.scaleBar.updateSettings(ScaleBarSettings(enabled: false));
    mapboxMap.logo.updateSettings(LogoSettings(enabled: false));
    mapboxMap.attribution.updateSettings(AttributionSettings(enabled: false));
    mapboxMap.compass.updateSettings(CompassSettings(enabled: false));

    final locationService = sl<LocationService>();
    final position = await locationService.getCurrentLocation();
    if (mounted && position != null) {
      mapboxMap.flyTo(
        CameraOptions(
          center: Point(
            coordinates: Position(position.longitude, position.latitude),
          ),
          zoom: 15,
        ),
        MapAnimationOptions(duration: 1500),
      );
    }

    mapboxMap.location.updateSettings(
      LocationComponentSettings(
        enabled: true,
        pulsingEnabled: true,
        pulsingMaxRadius: 40,
        showAccuracyRing: true,
        accuracyRingColor: 0xFFC4E0F9,
      ),
    );

    mapboxMap.gestures.updateSettings(GesturesSettings());

    pointAnnotationManager = await mapboxMap.annotations
        .createPointAnnotationManager();
    polylineAnnotationManager = await mapboxMap.annotations
        .createPolylineAnnotationManager();
    await _drawAnnotations();
    _annotationsDrawn = true;
  }

  Future<void> _drawAnnotations() async {
    if (_annotationsDrawn) return;
    if (pointAnnotationManager == null || !mounted) return;

    final annotations = context.read<MapCubit>().state.annotations;
    for (final entry in annotations) {
      final img = await buildMarkerImage(
        assetPath: PlaceCategory.fromCategoryId(
          entry.place.categoryId,
        ).iconAssetPath,
        sequenceNumber: entry.sequenceNumber,
      );

      final annotation = await pointAnnotationManager!.create(
        PointAnnotationOptions(
          geometry: Point(
            coordinates: Position(
              entry.place.location.longitude,
              entry.place.location.latitude,
            ),
          ),
          image: img,
          iconSize: 1.0,
        ),
      );

      _annotationIdToPlaceId[annotation.id] = entry.place.id;
    }

    // pointAnnotationManager!.addOnPointAnnotationClickListener(
    //   OnPointAnnotationClickListener((annotation) {
    //     final placeId = _annotationIdToPlaceId[annotation.id];
    //     if (placeId != null) {
    //       context.read<MapCubit>().selectPlace(placeId);
    //     }
    //     return true;
    //   }),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocListener<MapCubit, MapState>(
        listenWhen: (previous, current) =>
            previous.activeRoute != current.activeRoute,
        listener: (context, state) async {
          if (polylineAnnotationManager == null || mapboxMap == null) {
            return;
          }
          await polylineAnnotationManager!.deleteAll();

          if (state.activeRoute != null) {
            final geoJson = json.decode(state.activeRoute!.geoJsonGeometry);
            final rawCoords = geoJson['coordinates'] as List;
            final coordinates = rawCoords
                .map(
                  (c) => Position(
                    (c[0] as num).toDouble(),
                    (c[1] as num).toDouble(),
                  ),
                )
                .toList();

            await polylineAnnotationManager!.create(
              PolylineAnnotationOptions(
                geometry: LineString(coordinates: coordinates),
                lineColor: 0xFF2196F3,
                lineWidth: 5.0,
                lineOpacity: 0.8,
              ),
            );

            // Zoom camera to fit the route bounds
            if (coordinates.length >= 2) {
              final lats = coordinates.map((c) => c.lat.toDouble());
              final lngs = coordinates.map((c) => c.lng.toDouble());
              final sw = Position(
                lngs.reduce((a, b) => a < b ? a : b),
                lats.reduce((a, b) => a < b ? a : b),
              );
              final ne = Position(
                lngs.reduce((a, b) => a > b ? a : b),
                lats.reduce((a, b) => a > b ? a : b),
              );

              mapboxMap!
                  .cameraForCoordinateBounds(
                    CoordinateBounds(
                      southwest: Point(coordinates: sw),
                      northeast: Point(coordinates: ne),
                      infiniteBounds: false,
                    ),
                    MbxEdgeInsets(top: 80, left: 40, bottom: 80, right: 40),
                    null,
                    null,
                    null,
                    null,
                  )
                  .then((cameraOptions) {
                    mapboxMap!.flyTo(
                      cameraOptions,
                      MapAnimationOptions(duration: 1500),
                    );
                  });
            }
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            MapWidget(
              key: const ValueKey("mapWidget"),
              onMapCreated: _onMapCreated,
              styleUri: "mapbox://styles/mapbox/outdoors-v12",
            ),
            BlocBuilder<MapCubit, MapState>(
              buildWhen: (p, c) => p.activeRoute != c.activeRoute,
              builder: (context, state) {
                // if (state.activeRoute != null) {
                //   return const SizedBox.shrink();
                // }
                return Positioned(
                  top: MediaQuery.of(context).padding.top + 10,
                  // left: 0,
                  // right: 0,
                  child: const MapSearchBar(),
                );
              },
            ),
            // const MapNavigationBar(),
            Positioned(
              bottom: 120,
              right: 16,
              child: MapRelocateButton(onPressed: _relocateUser),
            ),
            const PlaceInfoBottomSheet(),
          ],
        ),
      ),
    );
  }
}
