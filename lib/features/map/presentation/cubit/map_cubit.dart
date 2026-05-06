import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import '../../../../core/shared/data/models/place_model.dart';
import '../../domain/entities/map_annotation_entry.dart';
import '../../domain/entities/google_place.dart';
import '../../domain/repositories/google_places_repository.dart';
import '../../domain/repositories/map_route_repository.dart';
import 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  final GooglePlacesRepository searchRepo;
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
        state.copyWith(
          selectedPlace: entry.place,
          isBottomSheetVisible: true,
          clearSelectedGooglePlace: true,
          selectedPlacePhotoUrls: [],
        ),
      );
    }
  }

  Future<void> showGooglePlaceDetails(GooglePlaceEntity place) async {
    emit(
      state.copyWith(
        selectedGooglePlace: place,
        clearSelectedPlace: true,
        isBottomSheetVisible: true,
        selectedPlacePhotoUrls: [],
      ),
    );

    if (place.photos != null && place.photos!.isNotEmpty) {
      await fetchPlacePhotoUrls(place.photos!);
    }
  }

  Future<void> fetchPlacePhotoUrls(List<dynamic> photos) async {
    final result = await searchRepo.fetchPlacePhotoUrls(photos);
    result.when(
      success: (urls) {
        if (urls.isNotEmpty) {
          emit(state.copyWith(selectedPlacePhotoUrls: urls));
        }
      },
      failure: (_) => null,
    );
  }

  void dismissBottomSheet() {
    emit(
      state.copyWith(
        isBottomSheetVisible: false,
        clearSelectedGooglePlace: true,
        selectedPlacePhotoUrls: [],
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
        showGooglePlaceDetails(place);
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

  void triggerFlyTo(double lat, double lng) {
    emit(state.copyWith(flyToLat: lat, flyToLng: lng));
  }

  void clearFlyToLocation() {
    emit(state.copyWith(clearFlyToLocation: true));
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
