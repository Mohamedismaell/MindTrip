import 'package:mindtrip/core/shared/presentation/bloc/safe_cubit.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/trips/domain/use_cases/change_trip_status_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/get_trip_details_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/review_trip_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/update_trip_plan_use_case.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/generated_plan_entity.dart';
import 'package:mindtrip/features/ai_planner/data/mapper/generated_plan_mapper.dart';
import 'package:mindtrip/features/ai_planner/data/models/collected_planner_data_model.dart';
import 'package:mindtrip/features/trips/data/models/update_trip_plan_request_model.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trip_details_state.dart';

class TripDetailsCubit extends SafeCubit<TripDetailsState> {
  TripDetailsCubit(
    this._getTripDetails,
    this._changeTripStatus,
    this._reviewTrip,
    this._updateTripPlan,
  ) : super(const TripDetailsState());

  final GetTripDetailsUseCase _getTripDetails;
  final ChangeTripStatusUseCase _changeTripStatus;
  final ReviewTripUseCase _reviewTrip;
  final UpdateTripPlanUseCase _updateTripPlan;

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

  Future<void> updatePlan(GeneratedPlanEntity plan) async {
    final currentTrip = state.trip;
    if (currentTrip == null) return;

    emitSafe(
      state.copyWith(
        generatedPlan: plan,
        trip: currentTrip.copyWith(plan: plan),
      ),
    );

    emitSafe(state.copyWith(actionStatus: TripDetailsActionStatus.loading));

    final request = UpdateTripPlanRequestModel(
      title: currentTrip.title,
      destinationGovernorate: currentTrip.destinationGovernorate,
      city: currentTrip.city,
      startDate: currentTrip.tripStart.toIso8601String(),
      endDate: currentTrip.tripEnd.toIso8601String(),
      people: currentTrip.people,
      totalBudgetEgp: currentTrip.totalBudget,
      totalCost: currentTrip.totalCost,
      plan: plan.toModel(),
      collected: currentTrip.collected != null
          ? CollectedDataModel.fromEntity(currentTrip.collected!)
          : null,
      sessionId: currentTrip.sessionId,
      isPublic: currentTrip.isPublic,
    );

    final result = await _updateTripPlan(currentTrip.tripId, request);

    result.when(
      success: (updatedTrip) => emitSafe(
        state.copyWith(
          actionStatus: TripDetailsActionStatus.success,
          trip: updatedTrip,
          generatedPlan: updatedTrip.plan,
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
}

