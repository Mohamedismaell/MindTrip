import 'package:equatable/equatable.dart';

sealed class MapSearchEvent extends Equatable {
  const MapSearchEvent();
}

final class SearchQueryChanged extends MapSearchEvent {
  const SearchQueryChanged(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}

final class SearchCleared extends MapSearchEvent {
  const SearchCleared();

  @override
  List<Object?> get props => [];
}

final class PredictionSelected extends MapSearchEvent {
  const PredictionSelected(this.placeId);

  final String placeId;

  @override
  List<Object?> get props => [placeId];
}

final class ClearResolvedPlace extends MapSearchEvent {
  const ClearResolvedPlace();

  @override
  List<Object?> get props => [];
}
