import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/core/errors/failure/failure.dart';
import 'package:mindtrip/features/map/domain/use_cases/fetch_place_details_use_case.dart';
import 'package:mindtrip/features/map/domain/use_cases/find_autocomplete_predictions_use_case.dart';
import '../../domain/entities/google_place.dart';
import 'map_search_state.dart';

class MapSearchCubit extends Cubit<MapSearchState> {
  final FindAutocompletePredictionsUseCase _findAutocompletePredictionsUseCase;
  final FetchPlaceDetailsUseCase _fetchPlaceDetailsUseCase;

  Timer? _searchDebounce;
  CancelToken? _autocompleteCancelToken;
  CancelToken? _resolveCancelToken;
  CancelToken? _nearbyCancelToken;

  MapSearchCubit({
    required FindAutocompletePredictionsUseCase
    findAutocompletePredictionsUseCase,
    required FetchPlaceDetailsUseCase fetchPlaceDetailsUseCase,
  }) : _findAutocompletePredictionsUseCase = findAutocompletePredictionsUseCase,
       _fetchPlaceDetailsUseCase = fetchPlaceDetailsUseCase,
       super(MapSearchState.initial());

  CancelToken _getAutocompleteToken() {
    _autocompleteCancelToken?.cancel();
    _autocompleteCancelToken = CancelToken();
    return _autocompleteCancelToken!;
  }

  CancelToken _resolveToken() {
    _resolveCancelToken?.cancel();
    _resolveCancelToken = CancelToken();
    return _resolveCancelToken!;
  }

  void search(String query) {
    final token = _getAutocompleteToken();
    if (_searchDebounce?.isActive ?? false) _searchDebounce!.cancel();

    if (query.isEmpty) {
      clearSearch();
      return;
    }

    _searchDebounce = Timer(const Duration(milliseconds: 300), () async {
      emit(state.copyWith(isSearchLoading: true, clearSearchError: true));

      final result = await _findAutocompletePredictionsUseCase.call(
        query,
        cancelToken: token,
      );

      result.when(
        success: (predictions) {
          if (!isClosed) {
            emit(
              state.copyWith(
                isSearchLoading: false,
                autocompletePredictions: predictions,
              ),
            );
          }
        },
        failure: (failure) {
          if (!isClosed && failure is! CancelledFailure) {
            emit(
              state.copyWith(
                isSearchLoading: false,
                searchError: failure.message,
              ),
            );
          }
        },
      );
    });
  }

  void clearSearch() {
    emit(
      state.copyWith(
        autocompletePredictions: const [],
        isSearchLoading: false,
        clearSearchError: true,
      ),
    );
  }

  Future<GooglePlaceEntity?> resolveAutocompleteResult(String placeId) async {
    emit(state.copyWith(isSearchLoading: true, clearSearchError: true));
    final token = _resolveToken();
    final result = await _fetchPlaceDetailsUseCase.call(
      placeId,
      cancelToken: token,
    );

    GooglePlaceEntity? resolvedPlace;
    result.when(
      success: (place) {
        resolvedPlace = place;
        if (!isClosed) {
          emit(
            state.copyWith(isSearchLoading: false, resolvedSearchPlace: place),
          );
          clearSearch();
        }
      },
      failure: (failure) {
        if (!isClosed && failure is! CancelledFailure) {
          emit(
            state.copyWith(
              isSearchLoading: false,
              searchError: failure.message,
            ),
          );
        }
      },
    );
    return resolvedPlace;
  }

  void clearResolvedSearchResult() {
    emit(state.copyWith(clearResolvedSearchPlace: true));
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    _autocompleteCancelToken?.cancel();
    _resolveCancelToken?.cancel();
    _nearbyCancelToken?.cancel();
    return super.close();
  }
}
