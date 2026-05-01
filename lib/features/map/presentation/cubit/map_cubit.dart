import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import '../../../../core/shared/data/models/place_model.dart';
import '../../domain/entities/map_annotation_entry.dart';
import '../../domain/entities/map_search_result.dart';
import '../../domain/repositories/map_search_repository.dart';
import '../../domain/repositories/map_route_repository.dart';
import 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  final MapSearchRepository searchRepo;
  final MapRouteRepository routeRepo;

  Timer? _searchDebounce;

  MapCubit({required this.searchRepo, required this.routeRepo})
    : super(MapState.initial());

  void loadPlaces(List<PlaceModel> places) {
    final annotations = List<MapAnnotationEntry>.generate(
      places.length,
      (index) =>
          MapAnnotationEntry(place: places[index], sequenceNumber: index + 1),
    );
    emit(state.copyWith(annotations: annotations));
  }

  void selectPlace(String placeId) {
    final entry = state.annotations
        .where((e) => e.place.id == placeId)
        .firstOrNull;
    if (entry != null) {
      emit(
        state.copyWith(selectedPlace: entry.place, isBottomSheetVisible: true),
      );
    }
  }

  void dismissBottomSheet() {
    emit(
      state.copyWith(
        isBottomSheetVisible: false,
        // We don't necessarily clear selectedPlace here so the sheet can animate down with content
      ),
    );
  }

  void search(String query) {
    if (_searchDebounce?.isActive ?? false) _searchDebounce!.cancel();

    if (query.isEmpty) {
      clearSearch();
      return;
    }

    _searchDebounce = Timer(const Duration(milliseconds: 300), () async {
      emit(state.copyWith(isSearchLoading: true, clearSearchError: true));

      final result = await searchRepo.suggest(query);

      result.when(
        success: (suggestions) {
          emit(
            state.copyWith(
              isSearchLoading: false,
              searchSuggestions: suggestions,
            ),
          );
        },
        failure: (error) {
          //no place info found
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
        searchSuggestions: const [],
        isSearchLoading: false,
        clearSearchError: true,
      ),
    );
  }

  Future<MapSearchResult?> resolveSearchResult(String mapboxId) async {
    emit(state.copyWith(isSearchLoading: true, clearSearchError: true));
    final result = await searchRepo.retrieve(mapboxId);

    MapSearchResult? searchResult;
    result.when(
      success: (data) {
        searchResult = data;
        emit(state.copyWith(isSearchLoading: false));
        clearSearch();
      },
      failure: (error) {
        emit(
          state.copyWith(isSearchLoading: false, searchError: error.message),
        );
      },
    );
    return searchResult;
  }

  Future<void> navigateToPlace(PlaceModel place, Position userPosition) async {
    final placePosition = Position(
      place.location.longitude,
      place.location.latitude,
    );
    await _fetchRoute([userPosition, placePosition]);
  }

  Future<void> navigateAll(Position userPosition) async {
    final waypoints = [userPosition];
    for (final entry in state.annotations) {
      waypoints.add(
        Position(entry.place.location.longitude, entry.place.location.latitude),
      );
    }
    await _fetchRoute(waypoints);
  }

  Future<void> _fetchRoute(List<Position> waypoints) async {
    emit(state.copyWith(isRouteLoading: true, clearRouteError: true));
    final result = await routeRepo.getRoute(waypoints);

    result.when(
      success: (route) {
        emit(state.copyWith(isRouteLoading: false, activeRoute: route));
      },
      failure: (error) {
        emit(state.copyWith(isRouteLoading: false, routeError: error.message));
      },
    );
  }

  void stopNavigation() {
    emit(state.copyWith(clearActiveRoute: true));
  }

  void setLocationGranted(bool granted) {
    emit(state.copyWith(isLocationGranted: granted));
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }
}
