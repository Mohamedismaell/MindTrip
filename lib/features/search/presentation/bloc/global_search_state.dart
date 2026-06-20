import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/features/search/domain/entity/recent_search_entity.dart';

part 'global_search_state.freezed.dart';

enum GlobalSearchStatus { initial, loading, success, error, loadingMore }

@freezed
abstract class GlobalSearchState with _$GlobalSearchState {
  const GlobalSearchState._();

  const factory GlobalSearchState({
    @Default([]) List<PlaceEntity> results,
    @Default([]) List<RecentSearchEntity> recentSearches,
    @Default(GlobalSearchStatus.initial) GlobalSearchStatus status,
    String? errorMessage,
    @Default(1) int currentPage,
    @Default(true) bool hasReachedMax,
    String? lastQuery,
  }) = _GlobalSearchState;

  factory GlobalSearchState.initial() => const GlobalSearchState();
}
