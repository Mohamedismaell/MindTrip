import 'dart:async';
import 'package:dio/dio.dart';
import 'package:mindtrip/core/shared/presentation/bloc/safe_cubit.dart';
import 'package:mindtrip/features/itinerary/domain/entities/trip_day.dart';
import 'package:mindtrip/features/map/domain/use_cases/fetch_place_photo_urls_use_case.dart';
import '../../../places/domain/entity/place_entity.dart';
import '../../../../core/shared/domain/entities/location_entity.dart';
import '../../../ai_planner/presentation/utils/trip_color_palette.dart';
import '../../domain/entities/map_annotation_entry.dart';
import '../../domain/entities/google_place.dart';
import 'map_state.dart';

class MapCubit extends SafeCubit<MapState> {
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
    final annotations = List<MapAnnotationEntry>.generate(
      places.length,
      (index) =>
          MapAnnotationEntry(place: places[index], sequenceNumber: index + 1),
    );
    emitSafe(
      state.copyWith(
        annotations: annotations,
        tripDays: null,
        selectedDayIndex: null,
      ),
    );
  }

  void loadPlace(PlaceEntity place) {
    final annotations = List<MapAnnotationEntry>.generate(
      1,
      (index) => MapAnnotationEntry(place: place, sequenceNumber: 1),
    );
    emitSafe(
      state.copyWith(
        annotations: annotations,
        tripDays: null,
        selectedDayIndex: null,
      ),
    );
  }

  void loadTripDays(List<TripDay> days) {
    emitSafe(state.copyWith(tripDays: days));
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

    emitSafe(
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
      emitSafe(state.copyWith(isBottomSheetVisible: true));
      triggerFlyTo(
        entry.place.location.latitude,
        entry.place.location.longitude,
      );
      return;
    }

    emitSafe(
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
    final placeModel = PlaceEntity(
      id: place.placeId,
      name: place.displayName,
      location: LocationEntity(
        address: place.formattedAddress ?? '',
        latitude: place.latitude ?? 0.0,
        longitude: place.longitude ?? 0.0,
        city: '',
        cityEn: '',
      ),
      description: place.editorialSummary,
      rating: place.rating,
      reviewCount: place.userRatingCount,
      isHiddenGem: false,
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

    emitSafe(
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
    emitSafe(
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
    emitSafe(state.copyWith(navigationPulse: state.navigationPulse + 1));
  }

  void removeSearchPlace(String placeId) {
    final annotations = List<MapAnnotationEntry>.from(state.annotations)
      ..removeWhere((e) => e.place.id == placeId && e.isSearchResult);

    if (state.selectedPlace?.id == placeId) {
      emitSafe(
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
      emitSafe(
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

    result.when(
      success: (urls) {
        if (urls.isEmpty) return;

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

          emitSafe(
            state.copyWith(
              selectedPlacePhotoUrls: urls,
              annotations: annotations,
              selectedPlace: updatedPlace,
            ),
          );
        } else {
          emitSafe(state.copyWith(selectedPlacePhotoUrls: urls));
        }
      },
      failure: (failure) {
        // Photo fetch failure is non-critical silently ignore.
      },
      cancelled: () {},
    );
  }

  //  UI helpers ──

  void dismissBottomSheet() {
    emitSafe(
      state.copyWith(
        isBottomSheetVisible: false,
        clearSelectedGooglePlace: true,
        selectedPlacePhotoUrls: [],
      ),
    );
  }

  void triggerFlyTo(double lat, double lng) {
    emitSafe(
      state.copyWith(
        flyToLat: lat,
        flyToLng: lng,
        flyToPulse: state.flyToPulse + 1,
      ),
    );
  }

  void clearFlyToLocation() {
    emitSafe(state.copyWith(flyToLat: null, flyToLng: null));
  }

  void setLocationGranted(bool granted) {
    emitSafe(state.copyWith(isLocationGranted: granted));
  }

  @override
  Future<void> close() {
    _photosCancelToken?.cancel();
    return super.close();
  }
}
