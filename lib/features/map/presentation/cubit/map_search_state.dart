// import 'package:freezed_annotation/freezed_annotation.dart';

// import '../../data/models/place_prediction.dart';
// import '../../domain/entities/google_place.dart';

// part 'map_search_state.freezed.dart';

// enum MapSearchStatus { initial, loading, success, error }

// @freezed
// sealed class MapSearchState with _$MapSearchState {
//   const MapSearchState._();

//   const factory MapSearchState({
//     @Default([]) List<PlacePrediction> autocompletePredictions,

//     @Default(MapSearchStatus.initial) MapSearchStatus searchStatus,
//     String? searchErrorMessage,

//     GooglePlaceEntity? resolvedSearchPlace,
//     @Default(false) bool clearResolvedSearchPlace,
//     @Default(false) bool clearSearchError,
//     @Default([]) List<GooglePlaceEntity> nearbyPlaces,
//   }) = _MapSearchState;

//   factory MapSearchState.initial() => const MapSearchState();
// }
