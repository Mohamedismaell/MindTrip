import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/shared/data/models/place_model.dart';
import '../../domain/entities/google_place.dart';
import '../../domain/entities/map_annotation_entry.dart';

part 'map_state.freezed.dart';

@freezed
sealed class MapState with _$MapState {
  const MapState._();

  const factory MapState({
    @Default([]) List<MapAnnotationEntry> annotations,

    PlaceModel? selectedPlace,

    GooglePlaceEntity? selectedGooglePlace,

    @Default([]) List<String> selectedPlacePhotoUrls,

    @Default(false) bool isBottomSheetVisible,

    @Default(false) bool isLocationGranted,
    @Default(false) bool clearSelectedPlace,
    @Default(false) bool clearSelectedGooglePlace,
    @Default(false) bool clearFlyToLocation,
    double? flyToLat,
    double? flyToLng,
  }) = _MapState;

  factory MapState.initial() => const MapState();
}
