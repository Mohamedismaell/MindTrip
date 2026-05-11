import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/core/errors/failure/failure.dart';
import 'package:mindtrip/features/map/domain/use_cases/fetch_place_photo_urls_use_case.dart';
import '../../../../core/shared/data/models/place_model.dart';
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
    emit(state.copyWith(annotations: annotations));
  }

  void selectPlace(String placeId) {
    final entry = state.annotations
        .where((e) => e.place.id == placeId)
        .firstOrNull;
    if (entry == null) return;

    // If the same place is already selected, toggle the sheet to re-trigger listeners
    if (state.selectedPlace?.id == placeId && state.isBottomSheetVisible) {
      return; // Already showing this place — no action needed
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
    final token = _getNewPhotosToken();

    final result = await _fetchPlacePhotoUrlsUseCase.call(
      photos,
      cancelToken: token,
    );

    result.when(
      success: (urls) {
        if (!isClosed && urls.isNotEmpty) {
          emit(state.copyWith(selectedPlacePhotoUrls: urls));
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
    emit(state.copyWith(flyToLat: lat, flyToLng: lng));
  }

  void clearFlyToLocation() {
    emit(state.copyWith(clearFlyToLocation: true));
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
