import 'package:mindtrip/core/shared/presentation/bloc/safe_cubit.dart';
import 'package:mindtrip/features/itinerary/domain/use_cases/get_itinerary_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/get_trip_by_id_use_case.dart';
import 'package:mindtrip/features/itinerary/presentation/cubit/trip_details_state.dart';

class TripDetailsCubit extends SafeCubit<TripDetailsState> {
  final GetTripByIdUseCase _getTripByIdUseCase;
  final GetItineraryUseCase _getItineraryUseCase;

  TripDetailsCubit(this._getTripByIdUseCase, this._getItineraryUseCase) : super(const TripDetailsState());

  Future<void> loadTripDetails(String tripId) async {
    emitSafe(state.copyWith(status: TripDetailsStatus.loading));

    final tripResult = await _getTripByIdUseCase(tripId);

    tripResult.when(
      success: (trip) async {
        final itineraryResult = await _getItineraryUseCase(tripId);

        itineraryResult.when(
          success: (itinerary) {
            emitSafe(
              state.copyWith(
                trip: trip,
                itinerary: itinerary,
                status: TripDetailsStatus.loaded,
              ),
            );
          },
          failure: (error) {
            emitSafe(
              state.copyWith(
                status: TripDetailsStatus.error,
                errorMessage: 'Failed to load trip details: ${error.message}',
              ),
            );
          },
          cancelled: () {},
        );
      },
      failure: (error) {
        emitSafe(
          state.copyWith(
            status: TripDetailsStatus.error,
            errorMessage: 'Failed to load trip details: ${error.message}',
          ),
        );
      },
      cancelled: () {},
    );
  }

  void toggleActiveDay(int dayNumber) {
    if (state.activeDay == dayNumber) {
      emitSafe(state.copyWith(clearActiveDay: true));
    } else {
      emitSafe(state.copyWith(activeDay: dayNumber));
    }
  }
}
