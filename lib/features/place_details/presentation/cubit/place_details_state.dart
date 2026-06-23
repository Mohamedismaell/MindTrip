import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/core/shared/models/pagination_state.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';

part 'place_details_state.freezed.dart';

enum PlaceDetailsStatus { initial, loading, loaded, error }

enum NearbyStatus { initial, loading, loaded, error }

extension PlaceDetailsStatusX on PlaceDetailsStatus {
  bool get isInitial => this == PlaceDetailsStatus.initial;

  bool get isLoading => this == PlaceDetailsStatus.loading;

  bool get isLoaded => this == PlaceDetailsStatus.loaded;

  bool get isError => this == PlaceDetailsStatus.error;
}

@freezed
abstract class PlaceDetailsState with _$PlaceDetailsState {
  const factory PlaceDetailsState({
    @Default(PlaceDetailsStatus.initial) PlaceDetailsStatus placeDetailsStatus,
    PlaceEntity? place,
    PlaceEntity? preview,
    String? placeDetailsError,
    @Default(NearbyStatus.initial) NearbyStatus nearbyStatus,
    @Default(PaginationState<PlaceEntity>())
    PaginationState<PlaceEntity> nearbyPlaces,
    String? nearbyError,
  }) = _PlaceDetailsState;
}
