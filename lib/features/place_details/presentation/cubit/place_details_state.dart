import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';

enum PlaceDetailsStatus { initial, loading, loaded, error }

class PlaceDetailsState extends Equatable {
  final PlaceDetailsStatus status;
  final PlaceEntity? place;
  final PlaceEntity? preview;
  final List<PlaceEntity> nearbyPlaces;
  final bool isNearbyLoading;
  final String? errorMessage;

  const PlaceDetailsState({
    this.status = PlaceDetailsStatus.initial,
    this.place,
    this.preview,
    this.nearbyPlaces = const [],
    this.isNearbyLoading = false,
    this.errorMessage,
  });

  PlaceDetailsState copyWith({
    PlaceDetailsStatus? status,
    PlaceEntity? place,
    PlaceEntity? preview,
    List<PlaceEntity>? nearbyPlaces,
    bool? isNearbyLoading,
    String? errorMessage,
  }) {
    return PlaceDetailsState(
      status: status ?? this.status,
      place: place ?? this.place,
      preview: preview ?? this.preview,
      nearbyPlaces: nearbyPlaces ?? this.nearbyPlaces,
      isNearbyLoading: isNearbyLoading ?? this.isNearbyLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        place,
        preview,
        nearbyPlaces,
        isNearbyLoading,
        errorMessage,
      ];
}
