import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/core/shared/models/pagination_state.dart';
import 'package:mindtrip/features/home/domain/entity/banner_entity.dart';
import 'package:mindtrip/core/enums/place_category.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/planner_preview_entity.dart';

part 'home_state.freezed.dart';

enum HomeDataStatus { initial, loading, success, failure }

extension HomeDataStatusX on HomeDataStatus {
  bool get isInitial => this == HomeDataStatus.initial;
  bool get isLoading => this == HomeDataStatus.loading;
  bool get isSuccess => this == HomeDataStatus.success;
  bool get isFailure => this == HomeDataStatus.failure;
  bool get isFinished =>
      this == HomeDataStatus.success || this == HomeDataStatus.failure;
}

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default(HomeDataStatus.initial) HomeDataStatus bannersStatus,
    @Default([]) List<BannerEntity> banners,
    @Default('') String bannersError,

    //popular
    @Default(HomeDataStatus.initial) HomeDataStatus popularPlacesStatus,
    @Default(PaginationState<PlaceEntity>())
    PaginationState<PlaceEntity> popularPlaces,
    @Default('') String popularPlacesError,
    //category
    @Default(HomeDataStatus.initial) HomeDataStatus categoryPlacesStatus,
    @Default(PaginationState<PlaceEntity>())
    PaginationState<PlaceEntity> categoryPlaces,
    @Default(PlaceCategory.food) PlaceCategory selectedCategory,
    @Default('') String categoryPlacesError,

    // @Default(HomeDataStatus.initial) HomeDataStatus recommendedPlacesStatus,
    // @Default([]) List<PlaceEntity> recommendedPlaces,
    // @Default('') String recommendedPlacesError,
    @Default(HomeDataStatus.initial) HomeDataStatus tourPackagesStatus,
    @Default('') String tourPackagesError,

    @Default(HomeDataStatus.initial) HomeDataStatus plannerPreviewsStatus,
    @Default([]) List<PlannerPreviewEntity> plannerPreviews,
    @Default('') String plannerPreviewsError,

    //hidden gems
    @Default(HomeDataStatus.initial) HomeDataStatus hiddenGemsStatus,
    @Default(PaginationState<PlaceEntity>())
    PaginationState<PlaceEntity> hiddenGems,
    @Default('') String hiddenGemsError,

    @Default([PlaceCategory.food, PlaceCategory.cafes, PlaceCategory.hotels])
    List<PlaceCategory> homeCategories,
  }) = _HomeState;
}
