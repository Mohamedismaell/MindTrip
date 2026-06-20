import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/core/errors/failure/failure.dart';
import 'package:mindtrip/core/utils/bloc_transformers.dart';
import 'package:mindtrip/features/search/data/models/search_places_request_model.dart';
import 'package:mindtrip/features/search/domain/use_cases/get_recent_searches_use_case.dart';
import 'package:mindtrip/features/search/domain/use_cases/save_recent_search_use_case.dart';
import 'package:mindtrip/features/search/domain/use_cases/clear_recent_searches_use_case.dart';
import 'package:mindtrip/features/search/domain/use_cases/search_places_use_case.dart';

import 'global_search_event.dart';
import 'global_search_state.dart';

class GlobalSearchBloc extends Bloc<GlobalSearchEvent, GlobalSearchState> {
  final SearchPlacesUseCase _searchPlacesUseCase;
  final GetRecentSearchesUseCase _getRecentSearchesUseCase;
  final SaveRecentSearchUseCase _saveRecentSearchUseCase;
  final ClearRecentSearchesUseCase _clearRecentSearchesUseCase;
  CancelToken? _cancelToken;

  GlobalSearchBloc({
    required SearchPlacesUseCase searchPlacesUseCase,
    required GetRecentSearchesUseCase getRecentSearchesUseCase,
    required SaveRecentSearchUseCase saveRecentSearchUseCase,
    required ClearRecentSearchesUseCase clearRecentSearchesUseCase,
  }) : _searchPlacesUseCase = searchPlacesUseCase,
       _getRecentSearchesUseCase = getRecentSearchesUseCase,
       _saveRecentSearchUseCase = saveRecentSearchUseCase,
       _clearRecentSearchesUseCase = clearRecentSearchesUseCase,
       super(GlobalSearchState.initial()) {
    on<SearchQueryChanged>(
      _onSearchQueryChanged,
      transformer: debounceRestartable(const Duration(milliseconds: 300)),
    );
    on<ClearSearch>(_onClearSearch);
    on<LoadNextPage>(_onLoadNextPage, transformer: droppable());
    on<LoadRecentSearches>(_onLoadRecentSearches);
    on<ClearRecentSearches>(_onClearRecentSearches);
    on<SaveRecentSearch>(_onSaveRecentSearch);

    // Initial load of recent searches
    add(const LoadRecentSearches());
  }

  Future<void> _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<GlobalSearchState> emit,
  ) async {
    final query = event.query.trim();

    if (query.isEmpty) {
      add(const ClearSearch());
      return;
    }

    if (query.length < 2 || query == state.lastQuery) return;

    emit(
      state.copyWith(
        status: GlobalSearchStatus.loading,
        lastQuery: query,
        errorMessage: null,
        results: [],
        currentPage: 1,
        hasReachedMax: false,
      ),
    );

    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    final result = await _searchPlacesUseCase(
      request: SearchPlacesRequestModel(query: query, page: 1, limit: 10),
      cancelToken: _cancelToken,
    );

    if (isClosed) return;

    result.when(
      success: (response) {
        emit(
          state.copyWith(
            status: GlobalSearchStatus.success,
            results: response.results,
            currentPage: response.page,
            hasReachedMax: response.page >= response.totalPages,
          ),
        );
      },
      failure: (failure) {
        if (isClosed || failure is CancelledFailure) return;
        emit(
          state.copyWith(
            status: GlobalSearchStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
    );
  }

  void _onClearSearch(ClearSearch event, Emitter<GlobalSearchState> emit) {
    _cancelToken?.cancel();
    emit(
      state.copyWith(
        status: GlobalSearchStatus.initial,
        results: [],
        lastQuery: null,
        currentPage: 1,
        hasReachedMax: true,
        errorMessage: null,
      ),
    );
  }

  Future<void> _onLoadNextPage(
    LoadNextPage event,
    Emitter<GlobalSearchState> emit,
  ) async {
    if (state.hasReachedMax || state.status == GlobalSearchStatus.loadingMore) {
      return;
    }

    emit(state.copyWith(status: GlobalSearchStatus.loadingMore));

    final result = await _searchPlacesUseCase(
      request: SearchPlacesRequestModel(
        query: state.lastQuery,
        page: state.currentPage + 1,
        limit: 10,
      ),
    );

    if (isClosed) return;

    result.when(
      success: (response) {
        emit(
          state.copyWith(
            status: GlobalSearchStatus.success,
            results: [...state.results, ...response.results],
            currentPage: response.page,
            hasReachedMax: response.page >= response.totalPages,
          ),
        );
      },
      failure: (failure) {
        if (isClosed || failure is CancelledFailure) return;
        emit(
          state.copyWith(
            status: GlobalSearchStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
    );
  }

  Future<void> _onLoadRecentSearches(
    LoadRecentSearches event,
    Emitter<GlobalSearchState> emit,
  ) async {
    final result = await _getRecentSearchesUseCase();
    result.when(
      success: (searches) {
        emit(state.copyWith(recentSearches: searches));
      },
      failure: (_) {},
    );
  }

  Future<void> _onClearRecentSearches(
    ClearRecentSearches event,
    Emitter<GlobalSearchState> emit,
  ) async {
    await _clearRecentSearchesUseCase();
    emit(state.copyWith(recentSearches: []));
  }

  Future<void> _onSaveRecentSearch(
    SaveRecentSearch event,
    Emitter<GlobalSearchState> emit,
  ) async {
    if (event.query.isEmpty) return;
    await _saveRecentSearchUseCase(event.query);
    add(const LoadRecentSearches());
  }

  @override
  Future<void> close() {
    _cancelToken?.cancel();
    return super.close();
  }
}
