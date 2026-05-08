import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/shared/data/models/place_model.dart';
import '../../domain/entities/map_annotation_entry.dart';
import '../../domain/entities/google_place.dart';
import '../../domain/repositories/google_places_repository.dart';
import 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  final GooglePlacesRepository searchRepo;

  MapCubit({required this.searchRepo}) : super(MapState.initial());

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

  void triggerFlyTo(double lat, double lng) {
    emit(state.copyWith(flyToLat: lat, flyToLng: lng));
  }

  void clearFlyToLocation() {
    emit(state.copyWith(clearFlyToLocation: true));
  }

  void setLocationGranted(bool granted) {
    emit(state.copyWith(isLocationGranted: granted));
  }
}
