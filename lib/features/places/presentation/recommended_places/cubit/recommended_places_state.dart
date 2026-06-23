part of 'recommended_places_cubit.dart';

enum RecommendedPlacesStatus { initial, loading, success, failure }

extension RecommendedPlacesStatusX on RecommendedPlacesStatus {
  bool get isInitial => this == RecommendedPlacesStatus.initial;
  bool get isLoading => this == RecommendedPlacesStatus.loading;
  bool get isSuccess => this == RecommendedPlacesStatus.success;
  bool get isFailure => this == RecommendedPlacesStatus.failure;
}

@freezed
abstract class RecommendedPlacesState with _$RecommendedPlacesState {
  const factory RecommendedPlacesState({
    @Default(RecommendedPlacesStatus.initial)
    RecommendedPlacesStatus recommendedPlacesStatus,
    @Default(PaginationState<PlaceEntity>())
    PaginationState<PlaceEntity> recommendedPlaces,
    @Default('') String recommededPlacesError,
    @Default(null) int? seed,
  }) = _RecommendedPlacesState;

  factory RecommendedPlacesState.initial() => const RecommendedPlacesState();
}
