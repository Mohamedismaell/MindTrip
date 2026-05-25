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
import 'package:mindtrip/features/map/presentation/cubit/map_navigation_state.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_state.dart';
import 'package:mindtrip/features/map/presentation/data/places_mock_data.dart';
import 'package:mindtrip/features/map/presentation/widgets/map_listener.dart';
import 'package:mindtrip/features/map/presentation/widgets/map_mark_relcoaiton_button.dart';
import 'package:mindtrip/features/map/presentation/widgets/map_relocate_button.dart';
import 'package:mindtrip/features/map/presentation/widgets/map_search_bar.dart';
import 'package:mindtrip/features/map/domain/utils/distance_utils.dart';
import 'package:mindtrip/features/map/presentation/widgets/map_navigate_all_button.dart';

import '../../data/models/map_trip_extra.dart';
import '../widgets/day_selector_bar.dart';
import '../widgets/place_card_row.dart';
import '../widgets/place_detail_sheet.dart';

class MapScreen extends StatefulWidget {
  final List<PlaceModel>? places;
  final MapTripExtra? tripExtra;

  const MapScreen({
    super.key,
    this.places,
    this.tripExtra,
  });

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
      context.read<MapCubit>().loadTripDays(widget.tripExtra!.days);
    } else {
      context.read<MapCubit>().loadPlaces(widget.places ?? PlacesMockData.mockPlaces);
    }
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
      
      final isTripMode = context.read<MapCubit>().state.hasTripDays;

      if (isTripMode) {
        // In trip mode, route in strict list order
        for (final entry in annotations) {
          waypoints.add(
            Position(
              entry.place.location.longitude,
              entry.place.location.latitude,
            ),
          );
        }
      } else {
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
      }

      context.read<MapNavigationCubit>().navigateAll(waypoints);
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
      if (!context.read<MapCubit>().state.hasTripDays) {
        await _autoSelectNearestPlace();
      }
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
    final hasTripDays = context.select<MapCubit, bool>((cubit) => cubit.state.hasTripDays);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: MultiBlocListener(
        listeners: [
          BlocListener<MapCubit, MapState>(
            listenWhen: (prev, curr) => !prev.isBottomSheetVisible && curr.isBottomSheetVisible,
            listener: (context, state) {
               PlaceDetailSheet.show(context);
            },
          ),
          BlocListener<MapCubit, MapState>(
            listenWhen: (prev, curr) => prev.selectedDayIndex != curr.selectedDayIndex,
            listener: (context, state) async {
              if (state.selectedDayIndex != null && state.annotations.isNotEmpty) {
                 final mapCubit = context.read<MapCubit>();
                 await Future.delayed(const Duration(milliseconds: 300));
                 if (context.mounted && mapCubit.state.annotations.isNotEmpty) {
                    _navigateAll();
                 }
              }
            },
          ),
          BlocListener<MapCubit, MapState>(
            listenWhen: (prev, curr) => prev.annotations != curr.annotations,
            listener: (context, state) async {
               if (state.annotations.isNotEmpty) {
                 await _mapController.addPlaceAnnotations(state.annotations);
                 await _mapController.fitToAnnotations();
               }
            },
          ),
        ],
        child: MapListener(
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
                 top: topSpace + 70.h,
                 child: BlocBuilder<MapNavigationCubit, MapNavigationState>(
                    builder: (context, state) {
                       final route = state.activeRoute;
                       if (route == null || state.isRouteLoading) return const SizedBox.shrink();
                       final durationMin = (route.duration / 60).ceil();
                       final profileLabel = state.selectedProfile.label.toLowerCase();
                       return Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
                          ),
                          child: Text(
                            '~$durationMin min $profileLabel',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                          ),
                       );
                    },
                 ),
              ),
              Positioned(
                bottom: hasTripDays ? 210.h : 130.h,
                right: 16.w,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (context.watch<MapCubit>().state.annotations.isNotEmpty && !hasTripDays) ...[
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
              Positioned(
                 bottom: hasTripDays ? 80.h : 30.h,
                 left: 0,
                 right: 0,
                 child: const PlaceCardRow(),
              ),
              if (hasTripDays)
                 Positioned(
                    bottom: 20.h,
                    left: 0,
                    right: 0,
                    child: const DaySelectorBar(),
                 ),
            ],
          ),
        ),
      ),
    );
  }
}
