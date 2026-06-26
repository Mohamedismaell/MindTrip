import 'package:mindtrip/core/shared/presentation/bloc/safe_cubit.dart';
import 'package:mindtrip/features/ai_planner/data/mapper/generated_plan_entity_json_mapper.dart';
import 'package:mindtrip/features/ai_planner/data/mapper/generated_plan_mapper.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/chat_cubit.dart';
import 'package:mindtrip/features/trips/data/models/create_trip_request_model.dart';
import 'package:mindtrip/features/trips/domain/entities/trip_details_args.dart';
import 'package:mindtrip/features/trips/domain/use_cases/get_trip_details_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/create_trip_use_case.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trip_details_state.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/generated_plan_entity.dart';

class TripDetailsCubit extends SafeCubit<TripDetailsState> {
  final GetTripDetailsUseCase _getTripDetails;
  final CreateTripUseCase _saveTrip;

  TripDetailsCubit(this._getTripDetails, this._saveTrip)
    : super(const TripDetailsState());

  void initialize(TripDetailsArgs args) async {
    if (args.generatedPlan != null) {
      emitSafe(
        state.copyWith(
          status: TripDetailsStatus.loaded,
          generatedPlan: args.generatedPlan,
        ),
      );
    } else if (args.tripId != null) {
      emitSafe(state.copyWith(status: TripDetailsStatus.loading));
      final result = await _getTripDetails(args.tripId!);
      result.when(
        success: (trip) => emitSafe(
          state.copyWith(status: TripDetailsStatus.loaded, trip: trip),
        ),
        failure: (error) => emitSafe(
          state.copyWith(
            status: TripDetailsStatus.error,
            errorMessage: error.message,
          ),
        ),
        cancelled: () =>
            emitSafe(state.copyWith(status: TripDetailsStatus.initial)),
      );
    }
  }

  void updateGeneratedPlan(GeneratedPlanEntity plan) {
    emitSafe(state.copyWith(generatedPlan: plan));
  }

  void toggleActiveDay(int day) {
    emit(state.copyWith(activeDay: state.activeDay == day ? 0 : day));
  }

  Future<void> saveTrip() async {
    final plan = state.generatedPlan;
    if (plan == null) return;

    emitSafe(state.copyWith(status: TripDetailsStatus.saving));
    final request = CreateTripRequestModel(
      title: '',
      destinationGovernorate: '',
      city: '',
      people: plan.people,
      totalBudgetEgp: plan.totalCalculatedCost,
      totalCost: plan.totalCalculatedCost,
      plan: plan.toModel(),
      sessionId: plan.tripId,
      isPublic: true,
      collected: context.read<ChatCubit>().state.collected.toModel(),
      status: 0,
    );

    final result = await _saveTrip(request);

    result.when(
      success: (trip) => emitSafe(
        state.copyWith(
          status: TripDetailsStatus.saved,
          trip: trip,
          generatedPlan: null,
        ),
      ),
      failure: (error) => emitSafe(
        state.copyWith(
          status: TripDetailsStatus.error,
          errorMessage: error.message,
        ),
      ),
      cancelled: () =>
          emitSafe(state.copyWith(status: TripDetailsStatus.loaded)),
    );
  }
}
