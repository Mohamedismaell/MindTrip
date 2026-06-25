import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/features/map/Services/location_service/location_service_imp.dart';
import 'package:mindtrip/features/map/domain/utils/distance_utils.dart';
import 'package:mindtrip/features/map/presentation/controllers/map_controller.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_cubit.dart';
import 'package:mindtrip/features/map/presentation/widgets/map_listener.dart';
import 'package:mindtrip/features/map/presentation/widgets/map_relocate_button.dart';
import 'package:mindtrip/features/map/presentation/widgets/map_search_bar.dart';
import 'package:mindtrip/features/map/presentation/widgets/navigaiotn_step.dart';

import '../../data/models/map_trip_extra.dart';
import '../widgets/day_selector_bar.dart';
import '../widgets/place_card_row.dart';

class MapScreen extends StatefulWidget {
  final PlaceEntity? place;
  final List<PlaceEntity>? places;
  final MapTripExtra? tripExtra;

  const MapScreen({super.key, this.places, this.tripExtra, this.place});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();

    if (widget.tripExtra != null) {
      context.read<MapCubit>().loadPlan(widget.tripExtra!.generatedPlan!);
    } else if (widget.places != null && widget.places!.isNotEmpty) {
      context.read<MapCubit>().loadPlaces(widget.places!);
    } else if (widget.place != null) {
      context.read<MapCubit>().loadPlace(widget.place!);
    }
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  // Current user position
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

    if (!mounted) return;

    final annotations = context.read<MapCubit>().state.annotations;

    if (annotations.isNotEmpty) {
      //! Annotations loaded before the map was ready
      await _mapController.addPlaceAnnotations(annotations);
      await _mapController.fitToAnnotations();

      if (mounted && !context.read<MapCubit>().state.hasTripDays) {
        await _autoSelectNearestPlace();
      }
    } else {
      await _flyToUserLocation();
    }
  }

  // Selects Nearest Place or first annotation

  Future<void> _autoSelectNearestPlace() async {
    if (!mounted) return;
    final annotations = context.read<MapCubit>().state.annotations;
    if (annotations.isEmpty) return;

    final position = await sl<LocationService>().getCurrentLocation();
    if (!mounted) return;

    if (position != null) {
      final nearest = DistanceUtils.findNearestAnnotation(
        annotations,
        position.latitude,
        position.longitude,
      );
      if (nearest != null && mounted) {
        context.read<MapCubit>().selectPlace(nearest.place.id);
        context.read<MapCubit>().triggerFlyTo(
          nearest.place.location.latitude,
          nearest.place.location.longitude,
        );
      }
    } else {
      //* select first place.
      if (mounted) {
        context.read<MapCubit>().selectPlace(annotations.first.place.id);
      }
    }
  }

  Future<void> _flyToUserLocation() async {
    final position = await sl<LocationService>().getCurrentLocation();
    if (mounted && position != null) {
      await _mapController.flyTo(position.latitude, position.longitude);
    }
  }

  @override
  Widget build(BuildContext context) {
    final topSpace = MediaQuery.of(context).padding.top + 10.h;
    final hasTripDays = context.select<MapCubit, bool>(
      (cubit) => cubit.state.hasTripDays,
    );

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
            //collapses the bottom sheet on tap.
            Positioned.fill(
              child: Listener(
                behavior: HitTestBehavior.translucent,
                onPointerDown: (_) {
                  if (context.read<MapCubit>().state.isBottomSheetVisible) {
                    context.read<MapCubit>().dismissBottomSheet();
                  }
                },
              ),
            ),
            if (!hasTripDays)
              Positioned(top: topSpace, child: const MapSearchBar()),
            Positioned(
              top: topSpace,
              left: 42.w,
              right: 42.w,
              child: NavigaiotnStep(),
            ),
            //  controls and cards
            Positioned(
              bottom: 20.h,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (hasTripDays) ...[
                          const DaySelectorBar(),
                          SizedBox(height: 12.h),
                          MapRelocateButton(
                            icon: Icons.directions_rounded,
                            onPressed: () {
                              context.read<MapCubit>().triggerNavigationPulse();
                            },
                          ),
                        ],
                        SizedBox(height: 12.h),
                        MapRelocateButton(onPressed: _relocateUser),
                      ],
                    ),
                  ),
                  const PlaceCardRow(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
