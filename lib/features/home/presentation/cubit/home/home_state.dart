import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/core/shared/domain/entities/banner_entity.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/core/shared/domain/entities/tour_package_entity.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/planner_preview_entity.dart';

part 'home_state.freezed.dart';

enum HomeDataStatus { initial, loading, success, failure }

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default(HomeDataStatus.initial) HomeDataStatus bannersStatus,
    @Default([]) List<BannerEntity> banners,
    @Default('') String bannersError,

    @Default(HomeDataStatus.initial) HomeDataStatus popularPlacesStatus,
    @Default([]) List<PlaceEntity> popularPlaces,
    @Default('') String popularPlacesError,

    @Default(HomeDataStatus.initial) HomeDataStatus recommendedPlacesStatus,
    @Default([]) List<PlaceEntity> recommendedPlaces,
    @Default('') String recommendedPlacesError,

    @Default(HomeDataStatus.initial) HomeDataStatus tourPackagesStatus,
    @Default([]) List<TourPackageEntity> tourPackages,
    @Default('') String tourPackagesError,

    @Default(HomeDataStatus.initial) HomeDataStatus plannerPreviewsStatus,
    @Default([]) List<PlannerPreviewEntity> plannerPreviews,
    @Default('') String plannerPreviewsError,
  }) = _HomeState;
}

extension HomeDataStatusX on HomeDataStatus {
  bool get isInitial => this == HomeDataStatus.initial;

  bool get isLoading => this == HomeDataStatus.loading;

  bool get isSuccess => this == HomeDataStatus.success;

  bool get isFailure => this == HomeDataStatus.failure;

  bool get isFinished =>
      this == HomeDataStatus.success || this == HomeDataStatus.failure;
}
