import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';

enum PlaceDetailsStatus { initial, loading, loaded, error }

enum NearbyStatus { initial, loading, loaded, error }

class PlaceDetailsState extends Equatable {
  final PlaceDetailsStatus placeDetailsStatus;
  final PlaceEntity? place;
  final PlaceEntity? preview;
  final List<PlaceEntity> nearbyPlaces;
  final NearbyStatus nearbyStatus;
  final String? errorMessage;

  const PlaceDetailsState({
    this.placeDetailsStatus = PlaceDetailsStatus.initial,
    this.place,
    this.preview,
    this.nearbyPlaces = const [],
    this.nearbyStatus = NearbyStatus.initial,
    this.errorMessage,
  });

  PlaceDetailsState copyWith({
    PlaceDetailsStatus? placeDetailsStatus,
    PlaceEntity? place,
    PlaceEntity? preview,
    List<PlaceEntity>? nearbyPlaces,
    NearbyStatus? nearbyStatus,
    String? errorMessage,
  }) {
    return PlaceDetailsState(
      placeDetailsStatus: placeDetailsStatus ?? this.placeDetailsStatus,
      place: place ?? this.place,
      preview: preview ?? this.preview,
      nearbyPlaces: nearbyPlaces ?? this.nearbyPlaces,
      nearbyStatus: nearbyStatus ?? this.nearbyStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    placeDetailsStatus,
    place,
    preview,
    nearbyPlaces,
    nearbyStatus,
    errorMessage,
  ];
}
