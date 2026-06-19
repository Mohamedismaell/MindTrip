import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/core/enums/place_category.dart';
import 'package:mindtrip/core/shared/models/pagination_state.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/features/places/data/models/get_places_request_model.dart';

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
  const ExploreState._();
  const factory ExploreState({
    @Default(ExploreDataStatus.initial) ExploreDataStatus trendingPlacesStatus,
    @Default(PaginationState<PlaceEntity>())
    PaginationState<PlaceEntity> trendingPlaces,
    @Default('') String trendingPlacesError,
    @Default(ExploreDataStatus.initial) ExploreDataStatus filteredPlacesStatus,
    @Default(PaginationState<PlaceEntity>())
    PaginationState<PlaceEntity> filteredPlaces,
    @Default('') String filteredPlacesError,
    @Default({PlaceCategory.all}) Set<PlaceCategory> selectedCategories,
    GetPlacesRequestModel? advancedFilters,
  }) = _ExploreState;

  factory ExploreState.initial() => const ExploreState();

  int get filterCount {
    int count = 0;
    if (advancedFilters != null) {
      if (advancedFilters!.city != null && advancedFilters!.city!.isNotEmpty) {
        count++;
      }
      if (advancedFilters!.category != null &&
          advancedFilters!.category!.isNotEmpty) {
        count++;
      }
      if (advancedFilters!.interests != null &&
          advancedFilters!.interests!.isNotEmpty) {
        count++;
      }
      if (advancedFilters!.minRating != null ||
          advancedFilters!.maxRating != null) {
        count++;
      }
      if (advancedFilters!.minPrice != null ||
          advancedFilters!.maxPrice != null) {
        count++;
      }
      if (advancedFilters!.hiddenGem == true) count++;
    } else {
      if (!selectedCategories.contains(PlaceCategory.all) &&
          selectedCategories.isNotEmpty) {
        count++;
      }
    }
    return count;
  }
}
