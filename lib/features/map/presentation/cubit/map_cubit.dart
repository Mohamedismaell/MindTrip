import 'dart:async';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/core/errors/failure/failure.dart';
import 'package:mindtrip/features/map/domain/use_cases/fetch_place_photo_urls_use_case.dart';
import '../../../../core/shared/data/models/place_model.dart';
import '../../../../core/shared/data/models/location_model.dart';
import '../../../ai_planner/domain/entities/trip_day.dart';
import '../../../ai_planner/domain/entities/time_slot.dart';
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

  CancelToken _getNewPhotosToken() {
    _photosCancelToken?.cancel();
    _photosCancelToken = CancelToken();
    return _photosCancelToken!;
  }

  void loadPlaces(List<PlaceModel> places) {
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

  void loadTripDays(List<TripDay> days) {
    emit(state.copyWith(tripDays: days));
    if (days.isNotEmpty) {
      selectDay(0);
    }
  }

  void selectDay(int dayIndex) {
    if (state.tripDays == null ||
        dayIndex < 0 ||
        dayIndex >= state.tripDays!.length) {
      return;
    }

    final day = state.tripDays![dayIndex];
    final annotations = <MapAnnotationEntry>[];
    int sequence = 1;

    for (final slot in day.timeSlots) {
      Color periodColor;
      String periodLabel;
      switch (slot.period) {
        case DayPeriod.morning:
          periodColor = TripColorPalette.getColorsForId('morning').edge;
          periodLabel = 'Morning';
          break;
        case DayPeriod.afternoon:
          periodColor = TripColorPalette.getColorsForId('afternoon').edge;
          periodLabel = 'Afternoon';
          break;
        case DayPeriod.evening:
          periodColor = TripColorPalette.getColorsForId('evening').edge;
          periodLabel = 'Evening';
          break;
      }

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

  void selectPlace(String placeId) {
    final entry = state.annotations
        .where((e) => e.place.id == placeId)
        .firstOrNull;
    if (entry == null) return;

    triggerFlyTo(entry.place.location.latitude, entry.place.location.longitude);

    // If the same place is already selected, toggle the sheet to re-trigger listeners
    if (state.selectedPlace?.id == placeId && state.isBottomSheetVisible) {
      return; // Already showing this place
    }

    // If sheet is collapsed but same place, just re-open
    if (state.selectedPlace?.id == placeId && !state.isBottomSheetVisible) {
      emit(state.copyWith(isBottomSheetVisible: true));
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
  }

  Future<void> showGooglePlaceDetails(GooglePlaceEntity place) async {
    final placeModel = PlaceModel(
      id: place.placeId,
      name: place.displayName,
      location: LocationModel(
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

  void removeSearchPlace(String placeId) {
    var annotations = List<MapAnnotationEntry>.from(state.annotations);
    annotations.removeWhere((e) => e.place.id == placeId && e.isSearchResult);

    if (state.selectedPlace?.id == placeId) {
      dismissBottomSheet();
      emit(state.copyWith(annotations: annotations, clearSelectedPlace: true));
    } else {
      emit(state.copyWith(annotations: annotations));
    }
  }

  Future<void> fetchPlacePhotoUrls(List<dynamic> photos) async {
    final token = _getNewPhotosToken();

    final result = await _fetchPlacePhotoUrlsUseCase.call(
      photos,
      cancelToken: token,
    );

    result.when(
      success: (urls) {
        if (!isClosed && urls.isNotEmpty) {
          var newState = state.copyWith(selectedPlacePhotoUrls: urls);

          if (state.selectedPlace != null &&
              (state.selectedPlace!.imageUrls == null ||
                  state.selectedPlace!.imageUrls!.isEmpty)) {
            final updatedPlace = PlaceModel(
              id: state.selectedPlace!.id,
              name: state.selectedPlace!.name,
              location: state.selectedPlace!.location,
              description: state.selectedPlace!.description,
              rating: state.selectedPlace!.rating,
              reviewCount: state.selectedPlace!.reviewCount,
              category: state.selectedPlace!.category,
              price: state.selectedPlace!.price,
              isFavorite: state.selectedPlace!.isFavorite,
              badge: state.selectedPlace!.badge,
              imageUrls: urls,
            );

            final annotations = List<MapAnnotationEntry>.from(
              state.annotations,
            );
            final index = annotations.indexWhere(
              (e) => e.place.id == updatedPlace.id,
            );
            if (index != -1) {
              annotations[index] = annotations[index].copyWith(
                place: updatedPlace,
              );
              newState = newState.copyWith(
                annotations: annotations,
                selectedPlace: updatedPlace,
              );
            }
          }
          emit(newState);
        }
      },
      failure: (failure) {
        if (failure is CancelledFailure) return;
      },
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

  void triggerFlyTo(double lat, double lng) {
    // We emit null first to ensure the listener sees a change if we're flying to the same spot twice
    emit(state.copyWith(flyToLat: null, flyToLng: null));
    emit(state.copyWith(flyToLat: lat, flyToLng: lng));
  }

  void clearFlyToLocation() {
    emit(state.copyWith(flyToLat: null, flyToLng: null));
  }

  void setLocationGranted(bool granted) {
    emit(state.copyWith(isLocationGranted: granted));
  }

  @override
  Future<void> close() {
    _photosCancelToken?.cancel();
    return super.close();
  }
}
