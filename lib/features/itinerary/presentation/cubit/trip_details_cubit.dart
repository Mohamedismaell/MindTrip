import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/features/itinerary/domain/use_cases/get_itinerary_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/get_trip_by_id_use_case.dart';
import 'package:mindtrip/features/itinerary/presentation/cubit/trip_details_state.dart';

class TripDetailsCubit extends Cubit<TripDetailsState> {
  final GetTripByIdUseCase _getTripByIdUseCase;
  final GetItineraryUseCase _getItineraryUseCase;

  TripDetailsCubit(this._getTripByIdUseCase, this._getItineraryUseCase) : super(const TripDetailsState());

  Future<void> loadTripDetails(String tripId) async {
    if (isClosed) return;
    emit(state.copyWith(status: TripDetailsStatus.loading));

    final tripResult = await _getTripByIdUseCase(tripId);
    if (isClosed) return;

    tripResult.when(
      success: (trip) async {
        final itineraryResult = await _getItineraryUseCase(tripId);
        if (isClosed) return;

        itineraryResult.when(
          success: (itinerary) {
            emit(
              state.copyWith(
                trip: trip,
                itinerary: itinerary,
                status: TripDetailsStatus.loaded,
              ),
            );
          },
          failure: (error) {
            emit(
              state.copyWith(
                status: TripDetailsStatus.error,
                errorMessage: 'Failed to load trip details: ${error.message}',
              ),
            );
          },
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            status: TripDetailsStatus.error,
            errorMessage: 'Failed to load trip details: ${error.message}',
          ),
        );
      },
    );
  }

  void toggleActiveDay(int dayNumber) {
    if (isClosed) return;
    if (state.activeDay == dayNumber) {
      emit(state.copyWith(clearActiveDay: true));
    } else {
      emit(state.copyWith(activeDay: dayNumber));
    }
  }
}

