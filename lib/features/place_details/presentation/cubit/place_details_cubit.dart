import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/features/place_details/domain/use_cases/get_nearby_places_use_case.dart';
import 'package:mindtrip/features/place_details/domain/use_cases/get_place_details_use_case.dart';
import 'package:mindtrip/features/place_details/presentation/cubit/place_details_state.dart';

//Todo: add cancel token
class PlaceDetailsCubit extends Cubit<PlaceDetailsState> {
  final GetPlaceDetailsUseCase _getDetails;
  final GetNearbyPlacesUseCase _getNearby;

  PlaceDetailsCubit({
    required GetPlaceDetailsUseCase getDetails,
    required GetNearbyPlacesUseCase getNearby,
  }) : _getDetails = getDetails,
       _getNearby = getNearby,
       super(const PlaceDetailsState());

  Future<void> loadPlaceDetails(String placeId, {PlaceEntity? preview}) async {
    if (preview != null) {
      if (isClosed) return;
      emit(
        state.copyWith(
          placeDetailsStatus: PlaceDetailsStatus.loading,
          preview: preview,
          place: state.place ?? preview,
        ),
      );
    } else {
      if (isClosed) return;
      emit(state.copyWith(placeDetailsStatus: PlaceDetailsStatus.loading));
    }

    final result = await _getDetails(placeId);

    result.when(
      success: (place) {
        if (isClosed) return;
        emit(
          state.copyWith(
            placeDetailsStatus: PlaceDetailsStatus.loaded,
            place: place,
            errorMessage: null,
          ),
        );
      },
      failure: (error) {
        if (isClosed) return;
        emit(
          state.copyWith(
            placeDetailsStatus: PlaceDetailsStatus.error,
            errorMessage: error.message,
          ),
        );
      },
    );
  }

  Future<void> loadNearbyPlaces(
    String placeId, {
    double? lat,
    double? lng,
  }) async {
    if (isClosed) return;
    emit(state.copyWith(nearbyStatus: NearbyStatus.loading));

    final result = await _getNearby(placeId, lat: lat, lng: lng);

    result.when(
      success: (places) {
        if (isClosed) return;
        emit(
          state.copyWith(
            nearbyPlaces: places,
            nearbyStatus: NearbyStatus.loaded,
          ),
        );
      },
      failure: (error) {
        if (isClosed) return;
        emit(
          state.copyWith(
            nearbyStatus: NearbyStatus.error,
            errorMessage: error.message,
          ),
        );
      },
    );
  }
}
