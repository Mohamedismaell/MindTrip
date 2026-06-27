import 'package:mindtrip/core/shared/presentation/bloc/safe_cubit.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/trips/domain/use_cases/change_trip_status_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/get_trip_details_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/review_trip_use_case.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trip_details_state.dart';

class TripDetailsCubit extends SafeCubit<TripDetailsState> {
  TripDetailsCubit(
    this._getTripDetails,
    this._changeTripStatus,
    this._reviewTrip,
  ) : super(const TripDetailsState());

  final GetTripDetailsUseCase _getTripDetails;
  final ChangeTripStatusUseCase _changeTripStatus;
  final ReviewTripUseCase _reviewTrip;

  Future<void> initialize(String tripId, {Trip? initialTrip}) async {
    if (initialTrip != null) {
      emitSafe(
        state.copyWith(
          status: TripDetailsStatus.loaded,
          trip: initialTrip,
          generatedPlan: initialTrip.plan,
        ),
      );
    } else {
      emitSafe(
        state.copyWith(status: TripDetailsStatus.loading, errorMessage: null),
      );
    }
    final result = await _getTripDetails(tripId);
    result.when(
      success: (trip) => emitSafe(
        state.copyWith(
          status: TripDetailsStatus.loaded,
          trip: trip,
          generatedPlan: trip?.plan,
          errorMessage: null,
        ),
      ),
      failure: (error) => emitSafe(
        state.copyWith(
          status: TripDetailsStatus.error,
          trip: null,
          generatedPlan: null,
          errorMessage: error.message,
        ),
      ),
      cancelled: () => emitSafe(
        state.copyWith(
          status: TripDetailsStatus.initial,
          trip: null,
          generatedPlan: null,
          errorMessage: null,
        ),
      ),
    );
  }

  void onDayChanged(int day) {
    emit(state.copyWith(activeDay: state.activeDay == day ? 0 : day));
  }

  void resetActionStatus() {
    emit(
      state.copyWith(
        actionStatus: TripDetailsActionStatus.idle,
        actionError: null,
      ),
    );
  }

  void togglePlaceChecked(String placeName) {
    final checked = Set<String>.from(state.checkedPlaces);
    if (checked.contains(placeName)) {
      checked.remove(placeName);
    } else {
      checked.add(placeName);
    }
    emit(state.copyWith(checkedPlaces: checked));
  }

  Future<void> changeTripStatus(int status) async {
    final trip = state.trip;
    if (trip == null) return;

    emitSafe(state.copyWith(actionStatus: TripDetailsActionStatus.loading));

    final result = await _changeTripStatus(trip.tripId, status);

    result.when(
      success: (updatedTrip) => emitSafe(
        state.copyWith(
          actionStatus: TripDetailsActionStatus.success,
          trip: updatedTrip,
        ),
      ),
      failure: (error) => emitSafe(
        state.copyWith(
          actionStatus: TripDetailsActionStatus.error,
          actionError: error.message,
        ),
      ),
      cancelled: () => resetActionStatus(),
    );
  }

  Future<void> reviewTrip(double rating, String comment) async {
    final trip = state.trip;
    if (trip == null) return;

    emitSafe(state.copyWith(actionStatus: TripDetailsActionStatus.loading));

    final result = await _reviewTrip(trip.tripId, rating.toInt(), comment);

    result.when(
      success: (_) => emitSafe(
        state.copyWith(actionStatus: TripDetailsActionStatus.success),
      ),
      failure: (error) => emitSafe(
        state.copyWith(
          actionStatus: TripDetailsActionStatus.error,
          actionError: error.message,
        ),
      ),
      cancelled: () => resetActionStatus(),
    );
  }
}
