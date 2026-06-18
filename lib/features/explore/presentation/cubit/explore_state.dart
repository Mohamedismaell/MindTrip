import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/core/shared/models/pagination_state.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';

part 'explore_state.freezed.dart';

enum ExploreDataStatus { initial, loading, success, failure }

extension ExploreDataStatusX on ExploreDataStatus {
  bool get isInitial => this == ExploreDataStatus.initial;
  bool get isLoading => this == ExploreDataStatus.loading;
  bool get isSuccess => this == ExploreDataStatus.success;
  bool get isFailure => this == ExploreDataStatus.failure;
}

@freezed
abstract class ExploreState with _$ExploreState {
  const factory ExploreState({
    @Default(ExploreDataStatus.initial) ExploreDataStatus trendingPlacesStatus,

    @Default(PaginationState<PlaceEntity>())
    PaginationState<PlaceEntity> trendingPlaces,

    @Default('') String trendingPlacesError,

    @Default(ExploreDataStatus.initial) ExploreDataStatus otherPlacesStatus,

    @Default(PaginationState<PlaceEntity>())
    PaginationState<PlaceEntity> otherPlaces,

    @Default('') String otherPlacesError,
  }) = _ExploreState;

  factory ExploreState.initial() => const ExploreState();
}
