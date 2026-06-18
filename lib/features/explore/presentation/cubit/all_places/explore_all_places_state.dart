import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/core/shared/models/pagination_state.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';

part 'explore_all_places_state.freezed.dart';

enum ExploreAllPlacesStatus { initial, loading, success, failure }

extension ExploreAllPlacesStatusX on ExploreAllPlacesStatus {
  bool get isInitial => this == ExploreAllPlacesStatus.initial;
  bool get isLoading => this == ExploreAllPlacesStatus.loading;
  bool get isSuccess => this == ExploreAllPlacesStatus.success;
  bool get isFailure => this == ExploreAllPlacesStatus.failure;
}

@freezed
abstract class ExploreAllPlacesState with _$ExploreAllPlacesState {
  const factory ExploreAllPlacesState({
    @Default(ExploreAllPlacesStatus.initial) ExploreAllPlacesStatus status,
    @Default(PaginationState<PlaceEntity>())
    PaginationState<PlaceEntity> places,
    @Default('') String error,
    @Default('') String searchQuery,
    @Default([]) List<String> selectedCategories,
    @Default({}) Map<String, dynamic> filters,
  }) = _ExploreAllPlacesState;

  factory ExploreAllPlacesState.initial() => const ExploreAllPlacesState();
}
