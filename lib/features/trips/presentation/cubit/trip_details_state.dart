import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/generated_plan_entity.dart';

enum TripDetailsStatus { initial, loading, loaded, saving, saved, error }

class TripDetailsState {
  final TripDetailsStatus status;
  final Trip? trip;
  final GeneratedPlanEntity? generatedPlan;
  final int activeDay;
  final String? errorMessage;

  const TripDetailsState({
    this.status = TripDetailsStatus.initial,
    this.trip,
    this.generatedPlan,
    this.activeDay = 1,
    this.errorMessage,
  });

  bool get isUnsaved => generatedPlan != null && trip == null;

  TripDetailsState copyWith({
    TripDetailsStatus? status,
    Trip? trip,
    GeneratedPlanEntity? generatedPlan,
    int? activeDay,
    String? errorMessage,
  }) {
    return TripDetailsState(
      status: status ?? this.status,
      trip: trip ?? this.trip,
      generatedPlan: generatedPlan ?? this.generatedPlan,
      activeDay: activeDay ?? this.activeDay,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
