import 'package:equatable/equatable.dart';
import '../../../../core/shared/data/models/place_model.dart';
import '../../data/models/place_prediction.dart';
import '../../domain/entities/google_place.dart';

class MapSearchState extends Equatable {
  final List<PlacePrediction> autocompletePredictions;
  final bool isSearchLoading;
  final String? searchError;
  final GooglePlaceEntity? resolvedSearchPlace;
  final List<GooglePlaceEntity> nearbyPlaces;

  const MapSearchState({
    required this.autocompletePredictions,
    required this.isSearchLoading,
    this.searchError,
    this.resolvedSearchPlace,
    this.nearbyPlaces = const [],
  });

  factory MapSearchState.initial() => const MapSearchState(
        autocompletePredictions: [],
        isSearchLoading: false,
        searchError: null,
        resolvedSearchPlace: null,
        nearbyPlaces: [],
      );

  MapSearchState copyWith({
    List<PlacePrediction>? autocompletePredictions,
    bool? isSearchLoading,
    String? searchError,
    bool clearSearchError = false,
    GooglePlaceEntity? resolvedSearchPlace,
    bool clearResolvedSearchPlace = false,
    List<GooglePlaceEntity>? nearbyPlaces,
  }) {
    return MapSearchState(
      autocompletePredictions:
          autocompletePredictions ?? this.autocompletePredictions,
      isSearchLoading: isSearchLoading ?? this.isSearchLoading,
      searchError: clearSearchError ? null : (searchError ?? this.searchError),
      resolvedSearchPlace: clearResolvedSearchPlace
          ? null
          : (resolvedSearchPlace ?? this.resolvedSearchPlace),
      nearbyPlaces: nearbyPlaces ?? this.nearbyPlaces,
    );
  }

  @override
  List<Object?> get props => [
        autocompletePredictions,
        isSearchLoading,
        searchError,
        resolvedSearchPlace,
        nearbyPlaces,
      ];
}
