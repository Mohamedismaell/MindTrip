import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';

enum ExploreDataStatus { initial, loading, success, failure }

class ExploreState extends Equatable {
  final ExploreDataStatus trendingPlacesStatus;
  final List<PlaceEntity> trendingPlaces;
  final String trendingPlacesError;

  final ExploreDataStatus otherPlacesStatus;
  final List<PlaceEntity> otherPlaces;
  final String otherPlacesError;

  const ExploreState({
    this.trendingPlacesStatus = ExploreDataStatus.initial,
    this.trendingPlaces = const [],
    this.trendingPlacesError = '',
    this.otherPlacesStatus = ExploreDataStatus.initial,
    this.otherPlaces = const [],
    this.otherPlacesError = '',
  });

  ExploreState copyWith({
    ExploreDataStatus? trendingPlacesStatus,
    List<PlaceEntity>? trendingPlaces,
    String? trendingPlacesError,
    ExploreDataStatus? otherPlacesStatus,
    List<PlaceEntity>? otherPlaces,
    String? otherPlacesError,
  }) {
    return ExploreState(
      trendingPlacesStatus: trendingPlacesStatus ?? this.trendingPlacesStatus,
      trendingPlaces: trendingPlaces ?? this.trendingPlaces,
      trendingPlacesError: trendingPlacesError ?? this.trendingPlacesError,
      otherPlacesStatus: otherPlacesStatus ?? this.otherPlacesStatus,
      otherPlaces: otherPlaces ?? this.otherPlaces,
      otherPlacesError: otherPlacesError ?? this.otherPlacesError,
    );
  }

  @override
  List<Object?> get props => [
        trendingPlacesStatus,
        trendingPlaces,
        trendingPlacesError,
        otherPlacesStatus,
        otherPlaces,
        otherPlacesError,
      ];
}
