import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/place_prediction.dart';
import '../../domain/entities/google_place.dart';

part 'map_search_state.freezed.dart';

enum MapSearchStatus { initial, loading, success, error }

@freezed
sealed class MapSearchState with _$MapSearchState {
  const MapSearchState._();

  const factory MapSearchState({
    // Autocomplete
    @Default([]) List<PlacePrediction> autocompletePredictions,
    @Default(MapSearchStatus.initial) MapSearchStatus autocompleteStatus,
    String? autocompleteErrorMessage,

    // Place Details
    GooglePlaceEntity? resolvedSearchPlace,
    @Default(MapSearchStatus.initial) MapSearchStatus placeDetailsStatus,
    String? placeDetailsErrorMessage,

    // Search Metadata
    String? lastQuery,

    // Nearby (future)
    @Default([]) List<GooglePlaceEntity> nearbyPlaces,
  }) = _MapSearchState;

  factory MapSearchState.initial() => const MapSearchState();

  // Convenience getters

  bool get isAutocompletLoading =>
      autocompleteStatus == MapSearchStatus.loading;
  bool get isPlaceDetailsLoading =>
      placeDetailsStatus == MapSearchStatus.loading;
}
