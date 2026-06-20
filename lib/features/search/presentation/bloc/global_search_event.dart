import 'package:equatable/equatable.dart';

sealed class GlobalSearchEvent extends Equatable {
  const GlobalSearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchQueryChanged extends GlobalSearchEvent {
  final String query;

  const SearchQueryChanged(this.query);

  @override
  List<Object?> get props => [query];
}

class ClearSearch extends GlobalSearchEvent {
  const ClearSearch();
}

class LoadNextPage extends GlobalSearchEvent {
  const LoadNextPage();
}

class LoadRecentSearches extends GlobalSearchEvent {
  const LoadRecentSearches();
}

class ClearRecentSearches extends GlobalSearchEvent {
  const ClearRecentSearches();
}

class SaveRecentSearch extends GlobalSearchEvent {
  final String query;

  const SaveRecentSearch(this.query);

  @override
  List<Object?> get props => [query];
}
