import 'package:mindtrip/core/shared/presentation/bloc/safe_cubit.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/features/place_details/domain/use_cases/get_place_details_use_case.dart';
import 'package:mindtrip/features/place_details/presentation/cubit/place_details_state.dart';

//Todo: add cancel token
class PlaceDetailsCubit extends SafeCubit<PlaceDetailsState> {
  final GetPlaceDetailsUseCase _getDetails;

  PlaceDetailsCubit({required GetPlaceDetailsUseCase getDetails})
    : _getDetails = getDetails,
      super(const PlaceDetailsState());

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
            errorMessage: null,
          ),
        );
      },
      failure: (error) {
        emitSafe(
          state.copyWith(
            placeDetailsStatus: PlaceDetailsStatus.error,
            errorMessage: error.message,
          ),
        );
      },
      cancelled: () {},
    );
  }
}
