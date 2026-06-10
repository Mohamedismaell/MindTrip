import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/shared/domain/entities/banner_entity.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/core/shared/domain/entities/tour_package_entity.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/planner_preview_entity.dart';

enum HomeDataStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeDataStatus bannersStatus;
  final List<BannerEntity> banners;
  final String bannersError;

  final HomeDataStatus popularPlacesStatus;
  final List<PlaceEntity> popularPlaces;
  final String popularPlacesError;

  final HomeDataStatus recommendedPlacesStatus;
  final List<PlaceEntity> recommendedPlaces;
  final String recommendedPlacesError;

  final HomeDataStatus tourPackagesStatus;
  final List<TourPackageEntity> tourPackages;
  final String tourPackagesError;

  final HomeDataStatus plannerPreviewsStatus;
  final List<PlannerPreviewEntity> plannerPreviews;
  final String plannerPreviewsError;

  const HomeState({
    this.bannersStatus = HomeDataStatus.initial,
    this.banners = const [],
    this.bannersError = '',
    this.popularPlacesStatus = HomeDataStatus.initial,
    this.popularPlaces = const [],
    this.popularPlacesError = '',
    this.recommendedPlacesStatus = HomeDataStatus.initial,
    this.recommendedPlaces = const [],
    this.recommendedPlacesError = '',
    this.tourPackagesStatus = HomeDataStatus.initial,
    this.tourPackages = const [],
    this.tourPackagesError = '',
    this.plannerPreviewsStatus = HomeDataStatus.initial,
    this.plannerPreviews = const [],
    this.plannerPreviewsError = '',
  });

  HomeState copyWith({
    HomeDataStatus? bannersStatus,
    List<BannerEntity>? banners,
    String? bannersError,
    HomeDataStatus? popularPlacesStatus,
    List<PlaceEntity>? popularPlaces,
    String? popularPlacesError,
    HomeDataStatus? recommendedPlacesStatus,
    List<PlaceEntity>? recommendedPlaces,
    String? recommendedPlacesError,
    HomeDataStatus? tourPackagesStatus,
    List<TourPackageEntity>? tourPackages,
    String? tourPackagesError,
    HomeDataStatus? plannerPreviewsStatus,
    List<PlannerPreviewEntity>? plannerPreviews,
    String? plannerPreviewsError,
  }) {
    return HomeState(
      bannersStatus: bannersStatus ?? this.bannersStatus,
      banners: banners ?? this.banners,
      bannersError: bannersError ?? this.bannersError,
      popularPlacesStatus: popularPlacesStatus ?? this.popularPlacesStatus,
      popularPlaces: popularPlaces ?? this.popularPlaces,
      popularPlacesError: popularPlacesError ?? this.popularPlacesError,
      recommendedPlacesStatus: recommendedPlacesStatus ?? this.recommendedPlacesStatus,
      recommendedPlaces: recommendedPlaces ?? this.recommendedPlaces,
      recommendedPlacesError: recommendedPlacesError ?? this.recommendedPlacesError,
      tourPackagesStatus: tourPackagesStatus ?? this.tourPackagesStatus,
      tourPackages: tourPackages ?? this.tourPackages,
      tourPackagesError: tourPackagesError ?? this.tourPackagesError,
      plannerPreviewsStatus: plannerPreviewsStatus ?? this.plannerPreviewsStatus,
      plannerPreviews: plannerPreviews ?? this.plannerPreviews,
      plannerPreviewsError: plannerPreviewsError ?? this.plannerPreviewsError,
    );
  }

  @override
  List<Object?> get props => [
        bannersStatus,
        banners,
        bannersError,
        popularPlacesStatus,
        popularPlaces,
        popularPlacesError,
        recommendedPlacesStatus,
        recommendedPlaces,
        recommendedPlacesError,
        tourPackagesStatus,
        tourPackages,
        tourPackagesError,
        plannerPreviewsStatus,
        plannerPreviews,
        plannerPreviewsError,
      ];
}
