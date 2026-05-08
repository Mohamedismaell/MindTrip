import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/google_place.dart';
import '../../domain/repositories/google_places_repository.dart';
import 'map_search_state.dart';

class MapSearchCubit extends Cubit<MapSearchState> {
  final GooglePlacesRepository searchRepo;
  Timer? _searchDebounce;

  MapSearchCubit({required this.searchRepo}) : super(MapSearchState.initial());

  void search(String query) {
    if (_searchDebounce?.isActive ?? false) _searchDebounce!.cancel();

    if (query.isEmpty) {
      clearSearch();
      return;
    }

    _searchDebounce = Timer(const Duration(milliseconds: 300), () async {
      emit(state.copyWith(isSearchLoading: true, clearSearchError: true));

      final result = await searchRepo.findAutocompletePredictions(query);

      result.when(
        success: (predictions) {
          emit(
            state.copyWith(
              isSearchLoading: false,
              autocompletePredictions: predictions,
            ),
          );
        },
        failure: (error) {
          emit(
            state.copyWith(isSearchLoading: false, searchError: error.message),
          );
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
    final result = await searchRepo.fetchPlaceDetails(placeId);

    GooglePlaceEntity? resolvedPlace;
    result.when(
      success: (place) {
        resolvedPlace = place;
        emit(
          state.copyWith(isSearchLoading: false, resolvedSearchPlace: place),
        );
        clearSearch();
      },
      failure: (error) {
        emit(
          state.copyWith(isSearchLoading: false, searchError: error.message),
        );
      },
    );
    return resolvedPlace;
  }

  void clearResolvedSearchResult() {
    emit(state.copyWith(clearResolvedSearchPlace: true));
  }

  Future<void> discoverNearby(double lat, double lng) async {
    emit(state.copyWith(isSearchLoading: true, clearSearchError: true));
    final result = await searchRepo.nearbySearch(lat, lng, 1500);

    result.when(
      success: (places) =>
          emit(state.copyWith(nearbyPlaces: places, isSearchLoading: false)),
      failure: (error) => emit(
        state.copyWith(isSearchLoading: false, searchError: error.message),
      ),
    );
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }
}
