import 'package:mindtrip/core/shared/presentation/bloc/safe_cubit.dart';
import 'package:mindtrip/features/trips/domain/entities/trip_details_args.dart';
import 'package:mindtrip/features/trips/domain/use_cases/get_trip_details_use_case.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trip_details_state.dart';

class TripDetailsCubit extends SafeCubit<TripDetailsState> {
  TripDetailsCubit(this._getTripDetails) : super(const TripDetailsState());

  final GetTripDetailsUseCase _getTripDetails;

  Future<void> initialize(TripDetailsArgs args) async {
    emitSafe(
      state.copyWith(status: TripDetailsStatus.loading, errorMessage: null),
    );
    final result = await _getTripDetails(args.tripId);
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

  void toggleActiveDay(int day) {
    emit(state.copyWith(activeDay: state.activeDay == day ? 0 : day));
  }

  // GeneratedPlanEntity? _extractGeneratedPlan(Trip trip) {
  //   final rawPlan = trip.planJson;
  //   if (rawPlan != null && rawPlan.isNotEmpty) {
  //     final generatedPlan = _parsePlanJson(
  //       rawPlan,
  //       trip: trip,
  //       isWrappedGeneratedPlan: false,
  //     );
  //     if (generatedPlan != null) {
  //       return generatedPlan;
  //     }
  //   }
  //   final rawCollected = trip.collectedJson;
  //   if (rawCollected != null && rawCollected.isNotEmpty) {
  //     return _parsePlanJson(
  //       rawCollected,
  //       trip: trip,
  //       isWrappedGeneratedPlan: true,
  //     );
  //   }
  //   return null;
  // }

  // GeneratedPlanEntity? _parsePlanJson(
  //   String rawJson, {
  //   required Trip trip,
  //   required bool isWrappedGeneratedPlan,
  // }) {
  //   try {
  //     final decoded = jsonDecode(rawJson);
  //     if (decoded is! Map<String, dynamic>) {
  //       return null;
  //     }
  //     if (isWrappedGeneratedPlan || decoded.containsKey('trip_id')) {
  //       return GeneratedPlanModel.fromJson(decoded).toEntity();
  //     }
  //     final planModel = PlanModel.fromJson(decoded);
  //     return GeneratedPlanModel(
  //       tripId: trip.sessionId ?? trip.backendTripId ?? trip.id,
  //       status: trip.status.name,
  //       people: trip.people,
  //       totalCalculatedCost: trip.totalCost,
  //       daysCount: planModel.days.length,
  //       plan: planModel,
  //     ).toEntity();
  //   } catch (_) {
  //     return null;
  //   }
  // }
}
