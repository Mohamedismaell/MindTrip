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
    @Default([]) List<PlaceEntity> places,
    @Default('') String error,
    @Default(1) int currentPage,
    @Default(true) bool hasMore,
    @Default(false) bool isMoreLoading,
    @Default(null) int? seed,
  }) = _RecommendedPlacesState;

  factory RecommendedPlacesState.initial() => const RecommendedPlacesState();
}
