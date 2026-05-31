import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/shared/domain/entities/place_entity.dart';
import '../../../ai_planner/domain/entities/trip_day.dart';
import '../../domain/entities/google_place.dart';
import '../../domain/entities/map_annotation_entry.dart';

part 'map_state.freezed.dart';

@freezed
sealed class MapState with _$MapState {
  const MapState._();

  const factory MapState({
    @Default([]) List<MapAnnotationEntry> annotations,

    PlaceEntity? selectedPlace,

    GooglePlaceEntity? selectedGooglePlace,

    @Default([]) List<String> selectedPlacePhotoUrls,

    @Default(false) bool isBottomSheetVisible,

    @Default(false) bool isLocationGranted,
    @Default(false) bool clearSelectedPlace,
    @Default(false) bool clearSelectedGooglePlace,
    @Default(false) bool clearFlyToLocation,

    /// Monotonically-increasing counter that bumps on every triggerFlyTo call.
    /// The MapListener uses this to reliably detect a new flyTo request even
    /// when the lat/lng coordinates are the same as the previous request.
    @Default(0) int flyToPulse,

    double? flyToLat,
    double? flyToLng,

    /// Trip days passed from trip‐details; null when map is opened standalone.
    /// Pulse that increments whenever we want to force-navigate to the route tab
    @Default(0) int navigationPulse,

    @Default(null) List<TripDay>? tripDays,

    /// Currently selected day (0-indexed); null means "all days".
    @Default(null) int? selectedDayIndex,
  }) = _MapState;

  factory MapState.initial() => const MapState();

  bool get hasTripDays => tripDays != null && tripDays!.isNotEmpty;
}
