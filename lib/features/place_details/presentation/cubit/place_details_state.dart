import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';

enum PlaceDetailsStatus { initial, loading, loaded, error }

class PlaceDetailsState extends Equatable {
  final PlaceDetailsStatus status;
  final PlaceModel? place;
  final PlaceModel? preview;
  final List<PlaceModel> nearbyPlaces;
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
    PlaceModel? place,
    PlaceModel? preview,
    List<PlaceModel>? nearbyPlaces,
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
