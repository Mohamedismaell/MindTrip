import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/core/errors/failure/failure.dart';
import 'package:mindtrip/features/map/domain/use_cases/fetch_place_photo_urls_use_case.dart';
import '../../../../core/shared/domain/entities/place_entity.dart';
import '../../../../core/shared/domain/entities/location_entity.dart';
import '../../../ai_planner/domain/entities/trip_day.dart';
import '../../../ai_planner/presentation/utils/trip_color_palette.dart';
import '../../domain/entities/map_annotation_entry.dart';
import '../../domain/entities/google_place.dart';
import 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  final FetchPlacePhotoUrlsUseCase _fetchPlacePhotoUrlsUseCase;

  CancelToken? _photosCancelToken;

  MapCubit({required FetchPlacePhotoUrlsUseCase fetchPlacePhotoUrlsUseCase})
    : _fetchPlacePhotoUrlsUseCase = fetchPlacePhotoUrlsUseCase,
      super(MapState.initial());

  //  Cancel token helpers

  CancelToken _getNewPhotosToken() {
    _photosCancelToken?.cancel();
    _photosCancelToken = CancelToken();
    return _photosCancelToken!;
  }

  //  Place loading ──

  void loadPlaces(List<PlaceEntity> places) {
    if (isClosed) return;
    final annotations = List<MapAnnotationEntry>.generate(
      places.length,
      (index) =>
          MapAnnotationEntry(place: places[index], sequenceNumber: index + 1),
    );
    emit(
      state.copyWith(
        annotations: annotations,
        tripDays: null,
        selectedDayIndex: null,
      ),
    );
  }

  void loadPlace(PlaceEntity place) {
    if (isClosed) return;
    final annotations = List<MapAnnotationEntry>.generate(
      1,
      (index) => MapAnnotationEntry(place: place, sequenceNumber: 1),
    );
    emit(
      state.copyWith(
        annotations: annotations,
        tripDays: null,
        selectedDayIndex: null,
      ),
    );
  }

  void loadTripDays(List<TripDay> days) {
    if (isClosed) return;
    emit(state.copyWith(tripDays: days));
    if (days.isNotEmpty) {
      selectDay(0);
    }
  }

  void selectDay(int dayIndex) {
    if (isClosed) return;
    if (state.tripDays == null ||
        dayIndex < 0 ||
        dayIndex >= state.tripDays!.length) {
      return;
    }

    final day = state.tripDays![dayIndex];
    final annotations = <MapAnnotationEntry>[];
    int sequence = 1;

    for (final slot in day.timeSlots) {
      final tripColors = TripColorPalette.getPeriodColors(slot.period);
      final periodColor = tripColors.edge;
      final periodLabel =
          slot.period.name[0].toUpperCase() + slot.period.name.substring(1);

      for (final place in slot.places) {
        annotations.add(
          MapAnnotationEntry(
            place: place,
            sequenceNumber: sequence++,
            periodColor: periodColor,
            periodLabel: periodLabel,
            dayNumber: day.dayNumber,
          ),
        );
      }
    }

    emit(
      state.copyWith(
        selectedDayIndex: dayIndex,
        annotations: annotations,
        clearSelectedPlace: true,
        selectedPlacePhotoUrls: [],
        isBottomSheetVisible: false,
      ),
    );
  }
  //  Place selection

  void selectPlace(String placeId) {
    if (isClosed) return;
    final entry = state.annotations
        .where((e) => e.place.id == placeId)
        .firstOrNull;
    if (entry == null) return;

    if (state.selectedPlace?.id == placeId && state.isBottomSheetVisible) {
      triggerFlyTo(
        entry.place.location.latitude,
        entry.place.location.longitude,
      );
      return;
    }

    if (state.selectedPlace?.id == placeId && !state.isBottomSheetVisible) {
      emit(state.copyWith(isBottomSheetVisible: true));
      triggerFlyTo(
        entry.place.location.latitude,
        entry.place.location.longitude,
      );
      return;
    }

    emit(
      state.copyWith(
        selectedPlace: entry.place,
        isBottomSheetVisible: true,
        clearSelectedGooglePlace: true,
        selectedPlacePhotoUrls: [],
      ),
    );
    triggerFlyTo(entry.place.location.latitude, entry.place.location.longitude);
  }

  Future<void> showGooglePlaceDetails(GooglePlaceEntity place) async {
    if (isClosed) return;
    final placeModel = PlaceEntity(
      id: place.placeId,
      name: place.displayName,
      location: LocationEntity(
        address: place.formattedAddress ?? '',
        latitude: place.latitude ?? 0.0,
        longitude: place.longitude ?? 0.0,
      ),
      description: place.editorialSummary,
      rating: place.rating,
      reviewCount: place.userRatingCount,
    );

    final newEntry = MapAnnotationEntry(
      place: placeModel,
      sequenceNumber: state.annotations.length + 1,
      isSearchResult: true,
      googlePlace: place,
    );

    final updatedAnnotations = List<MapAnnotationEntry>.from(state.annotations)
      ..removeWhere((e) => e.place.id == place.placeId)
      ..add(newEntry);

    if (isClosed) return;
    emit(
      state.copyWith(
        annotations: updatedAnnotations,
        selectedPlace: placeModel,
        selectedGooglePlace: place,
        isBottomSheetVisible: true,
        selectedPlacePhotoUrls: [],
      ),
    );

    triggerFlyTo(placeModel.location.latitude, placeModel.location.longitude);

    if (place.photos != null && place.photos!.isNotEmpty) {
      await fetchPlacePhotoUrls(place.photos!);
    }
  }

  void clearSelection() {
    if (isClosed) return;
    emit(
      state.copyWith(
        clearSelectedPlace: true,
        clearSelectedGooglePlace: true,
        isBottomSheetVisible: false,
        selectedPlacePhotoUrls: [],
        navigationPulse: state.navigationPulse + 1,
      ),
    );
  }

  void triggerNavigationPulse() {
    if (isClosed) return;
    emit(state.copyWith(navigationPulse: state.navigationPulse + 1));
  }

  void removeSearchPlace(String placeId) {
    if (isClosed) return;
    final annotations = List<MapAnnotationEntry>.from(state.annotations)
      ..removeWhere((e) => e.place.id == placeId && e.isSearchResult);

    if (state.selectedPlace?.id == placeId) {
      emit(
        state.copyWith(
          annotations: annotations,
          clearSelectedPlace: true,
          isBottomSheetVisible: false,
          selectedPlacePhotoUrls: [],
          clearSelectedGooglePlace: true,
          navigationPulse: state.navigationPulse + 1,
        ),
      );
    } else {
      emit(
        state.copyWith(
          annotations: annotations,
          navigationPulse: state.navigationPulse + 1,
        ),
      );
    }
  }

  //  Photos

  Future<void> fetchPlacePhotoUrls(List<dynamic> photos) async {
    final token = _getNewPhotosToken();

    final result = await _fetchPlacePhotoUrlsUseCase.call(
      photos,
      cancelToken: token,
    );

    if (isClosed) return;

    result.when(
      success: (urls) {
        if (isClosed || urls.isEmpty) return;

        if (state.selectedPlace != null &&
            (state.selectedPlace!.imageUrls == null ||
                state.selectedPlace!.imageUrls!.isEmpty)) {
          final updatedPlace = state.selectedPlace!.copyWith(imageUrls: urls);

          final annotations = List<MapAnnotationEntry>.from(state.annotations);
          final index = annotations.indexWhere(
            (e) => e.place.id == updatedPlace.id,
          );
          if (index != -1) {
            annotations[index] = annotations[index].copyWith(
              place: updatedPlace,
            );
          }

          emit(
            state.copyWith(
              selectedPlacePhotoUrls: urls,
              annotations: annotations,
              selectedPlace: updatedPlace,
            ),
          );
        } else {
          emit(state.copyWith(selectedPlacePhotoUrls: urls));
        }
      },
      failure: (failure) {
        if (failure is CancelledFailure) return;
        // Photo fetch failure is non-critical  silently ignore.
      },
    );
  }

  //  UI helpers ──

  void dismissBottomSheet() {
    if (isClosed) return;
    emit(
      state.copyWith(
        isBottomSheetVisible: false,
        clearSelectedGooglePlace: true,
        selectedPlacePhotoUrls: [],
      ),
    );
  }

  void triggerFlyTo(double lat, double lng) {
    if (isClosed) return;
    emit(
      state.copyWith(
        flyToLat: lat,
        flyToLng: lng,
        flyToPulse: state.flyToPulse + 1,
      ),
    );
  }

  void clearFlyToLocation() {
    if (isClosed) return;
    emit(state.copyWith(flyToLat: null, flyToLng: null));
  }

  void setLocationGranted(bool granted) {
    if (isClosed) return;
    emit(state.copyWith(isLocationGranted: granted));
  }

  @override
  Future<void> close() {
    _photosCancelToken?.cancel();
    return super.close();
  }
}
