import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/trip_repository.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trip_details_state.dart';

class TripDetailsCubit extends Cubit<TripDetailsState> {
  final TripRepository _tripRepository;

  TripDetailsCubit(this._tripRepository) : super(const TripDetailsState());

  Future<void> loadTripDetails(String tripId) async {
    if (isClosed) return;
    emit(state.copyWith(status: TripDetailsStatus.loading));

    try {
      final trip = await _tripRepository.getTripById(tripId);
      final itinerary = await _tripRepository.getItinerary(tripId);

      if (isClosed) return;
      emit(
        state.copyWith(
          trip: trip,
          itinerary: itinerary,
          status: TripDetailsStatus.loaded,
        ),
      );
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          status: TripDetailsStatus.error,
          errorMessage: 'Failed to load trip details: $e',
        ),
      );
    }
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
