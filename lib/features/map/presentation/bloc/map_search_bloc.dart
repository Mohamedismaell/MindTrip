import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/core/shared/presentation/bloc/safe_bloc.dart';
import 'package:mindtrip/features/map/domain/use_cases/fetch_place_details_use_case.dart';
import 'package:mindtrip/features/map/domain/use_cases/find_autocomplete_predictions_use_case.dart';

import 'package:mindtrip/core/utils/bloc_transformers.dart';
import 'map_search_event.dart';
import 'map_search_state.dart';

class MapSearchBloc extends SafeBloc<MapSearchEvent, MapSearchState> {
  final FindAutocompletePredictionsUseCase _findAutocompletePredictionsUseCase;
  final FetchPlaceDetailsUseCase _fetchPlaceDetailsUseCase;

  CancelToken? _autocompleteToken;
  CancelToken? _detailsToken;

  MapSearchBloc({
    required FindAutocompletePredictionsUseCase
    findAutocompletePredictionsUseCase,
    required FetchPlaceDetailsUseCase fetchPlaceDetailsUseCase,
  }) : _findAutocompletePredictionsUseCase = findAutocompletePredictionsUseCase,
       _fetchPlaceDetailsUseCase = fetchPlaceDetailsUseCase,
       super(MapSearchState.initial()) {
    on<SearchQueryChanged>(
      _onSearchQueryChanged,
      transformer: debounceRestartable(const Duration(milliseconds: 300)),
    );
    on<SearchCleared>(_onSearchCleared);
    on<PredictionSelected>(_onPredictionSelected, transformer: restartable());
    on<ClearResolvedPlace>(_onClearResolvedPlace);
  }

  // Token helpers

  CancelToken _replaceAutocompleteToken() {
    _autocompleteToken?.cancel();
    _autocompleteToken = CancelToken();
    return _autocompleteToken!;
  }

  CancelToken _replaceDetailsToken() {
    _detailsToken?.cancel();
    _detailsToken = CancelToken();
    return _detailsToken!;
  }

  // Event handlers

  Future<void> _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<MapSearchState> emit,
  ) async {
    final query = event.query.trim();

    if (query.isEmpty) {
      _clearSearch(emit);
      return;
    }

    if (query.length < 2 || query == state.lastQuery) return;

    if (state.autocompleteStatus != MapSearchStatus.loading) {
      emitSafe(
        emit,
        state.copyWith(
          autocompleteStatus: MapSearchStatus.loading,
          autocompleteErrorMessage: null,
          lastQuery: query,
        ),
      );
    }

    final token = _replaceAutocompleteToken();

    final result = await _findAutocompletePredictionsUseCase.call(
      query,
      cancelToken: token,
    );
    
    result.when(
      success: (predictions) => emitSafe(
        emit,
        state.copyWith(
          autocompleteStatus: MapSearchStatus.success,
          autocompletePredictions: predictions,
        ),
      ),
      failure: (failure) {
        emitSafe(
          emit,
          state.copyWith(
            autocompleteStatus: MapSearchStatus.error,
            autocompleteErrorMessage: failure.message,
          ),
        );
      },
      cancelled: () {},
    );
  }

  void _onSearchCleared(SearchCleared event, Emitter<MapSearchState> emit) {
    _clearSearch(emit);
  }

  void _clearSearch(Emitter<MapSearchState> emit) {
    _autocompleteToken?.cancel();
    emitSafe(
      emit,
      state.copyWith(
        autocompletePredictions: const [],
        autocompleteStatus: MapSearchStatus.initial,
        autocompleteErrorMessage: null,
        lastQuery: null,
      ),
    );
  }

  Future<void> _onPredictionSelected(
    PredictionSelected event,
    Emitter<MapSearchState> emit,
  ) async {
    emitSafe(
      emit,
      state.copyWith(
        placeDetailsStatus: MapSearchStatus.loading,
        placeDetailsErrorMessage: null,
      ),
    );

    final token = _replaceDetailsToken();

    final result = await _fetchPlaceDetailsUseCase.call(
      event.placeId,
      cancelToken: token,
    );
    
    result.when(
      success: (place) {
        emitSafe(
          emit,
          state.copyWith(
            placeDetailsStatus: MapSearchStatus.success,
            resolvedSearchPlace: place,
            autocompletePredictions: const [],
            autocompleteStatus: MapSearchStatus.initial,
            autocompleteErrorMessage: null,
            lastQuery: null,
          ),
        );
        _autocompleteToken?.cancel();
      },
      failure: (failure) {
        emitSafe(
          emit,
          state.copyWith(
            placeDetailsStatus: MapSearchStatus.error,
            placeDetailsErrorMessage: failure.message,
          ),
        );
      },
      cancelled: () {},
    );
  }

  void _onClearResolvedPlace(
    ClearResolvedPlace event,
    Emitter<MapSearchState> emit,
  ) {
    emitSafe(
      emit,
      state.copyWith(
        resolvedSearchPlace: null,
        placeDetailsStatus: MapSearchStatus.initial,
        placeDetailsErrorMessage: null,
      ),
    );
  }

  // Lifecycle
  @override
  Future<void> close() {
    _autocompleteToken?.cancel();
    _detailsToken?.cancel();
    return super.close();
  }
}
