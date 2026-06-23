import 'package:dio/dio.dart';
import 'package:mindtrip/core/shared/presentation/bloc/safe_cubit.dart';
import 'package:mindtrip/features/places/data/models/nearby_places_request_model.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/features/place_details/domain/use_cases/get_place_details_use_case.dart';
import 'package:mindtrip/features/place_details/domain/use_cases/get_nearby_places_use_case.dart';
import 'package:mindtrip/features/place_details/presentation/cubit/place_details_state.dart';

//Todo: add cancel token
class PlaceDetailsCubit extends SafeCubit<PlaceDetailsState> {
  final GetPlaceDetailsUseCase _getDetails;
  final GetNearbyPlacesUseCase _getNearby;

  PlaceDetailsCubit({
    required GetPlaceDetailsUseCase getDetails,
    required GetNearbyPlacesUseCase getNearby,
  }) : _getDetails = getDetails,
       _getNearby = getNearby,
       super(const PlaceDetailsState());

  CancelToken? _nearbyFirstPageToken;
  CancelToken? _nearbyLoadMoreToken;

  Future<void> loadPlaceDetails(String placeId, {PlaceEntity? preview}) async {
    if (preview != null) {
      emitSafe(
        state.copyWith(
          placeDetailsStatus: PlaceDetailsStatus.loading,
          preview: preview,
          place: state.place ?? preview,
        ),
      );
    } else {
      emitSafe(state.copyWith(placeDetailsStatus: PlaceDetailsStatus.loading));
    }

    final result = await _getDetails(placeId);

    result.when(
      success: (place) {
        emitSafe(
          state.copyWith(
            placeDetailsStatus: PlaceDetailsStatus.loaded,
            place: place,
            placeDetailsError: null,
          ),
        );
      },
      failure: (error) {
        emitSafe(
          state.copyWith(
            placeDetailsStatus: PlaceDetailsStatus.error,
            placeDetailsError: error.message,
          ),
        );
      },
      cancelled: () {},
    );
  }

  Future<void> loadFirstPageNearbyPlaces(
    String placeId, {
    double? lat,
    double? lng,
    int? limit,
  }) async {
    _nearbyFirstPageToken?.cancel();
    _nearbyFirstPageToken = CancelToken();

    emitSafe(state.copyWith(nearbyStatus: NearbyStatus.loading));

    final result = await _getNearby(
      request: NearbyPlacesRequestModel(
        userLat: lat ?? state.place?.location.latitude ?? 0,
        userLng: lng ?? state.place?.location.longitude ?? 0,
      ),
    );

    result.when(
      success: (nearby) {
        emitSafe(
          state.copyWith(
            nearbyStatus: NearbyStatus.loaded,
            nearbyPlaces: state.nearbyPlaces.copyWith(
              currentPage: nearby.page,
              items: nearby.results,
              hasMore: nearby.page < nearby.totalPages,
            ),
          ),
        );
      },
      failure: (error) {
        emitSafe(
          state.copyWith(
            nearbyStatus: NearbyStatus.error,
            nearbyError: error.message,
          ),
        );
      },
      cancelled: () {},
    );
  }

  Future<void> loadMoreNearbyPlaces(
    String placeId, {
    double? lat,
    double? lng,
  }) async {
    if (state.nearbyPlaces.isMoreLoading ||
        state.nearbyStatus == NearbyStatus.loading ||
        !state.nearbyPlaces.hasMore) {
      return;
    }

    _nearbyLoadMoreToken?.cancel();
    _nearbyLoadMoreToken = CancelToken();

    emitSafe(
      state.copyWith(
        nearbyPlaces: state.nearbyPlaces.copyWith(isMoreLoading: true),
      ),
    );

    final nextPage = state.nearbyPlaces.currentPage + 1;
    final result = await _getNearby(
      request: NearbyPlacesRequestModel(
        userLat: lat ?? state.place?.location.latitude ?? 0,
        userLng: lng ?? state.place?.location.longitude ?? 0,
        page: nextPage,
      ),
    );

    result.when(
      success: (nearby) {
        emitSafe(
          state.copyWith(
            nearbyPlaces: state.nearbyPlaces.copyWith(
              isMoreLoading: false,
              items: [...state.nearbyPlaces.items, ...nearby.results],
              currentPage: nearby.page,
              hasMore: nearby.page < nearby.totalPages,
            ),
          ),
        );
      },
      failure: (error) {
        emitSafe(
          state.copyWith(
            nearbyPlaces: state.nearbyPlaces.copyWith(isMoreLoading: false),
            nearbyError: error.message,
          ),
        );
      },
      cancelled: () {},
    );
  }

  @override
  Future<void> close() {
    _nearbyFirstPageToken?.cancel();
    _nearbyLoadMoreToken?.cancel();
    return super.close();
  }
}
