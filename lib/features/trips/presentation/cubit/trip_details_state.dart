import 'package:mindtrip/features/ai_planner/domain/entities/generated_plan_entity.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';

enum TripDetailsStatus { initial, loading, loaded, error }

class TripDetailsState {
  const TripDetailsState({
    this.status = TripDetailsStatus.initial,
    this.trip,
    this.generatedPlan,
    this.activeDay = 1,
    this.errorMessage,
  });

  static const _unset = Object();

  final TripDetailsStatus status;
  final Trip? trip;
  final GeneratedPlanEntity? generatedPlan;
  final int activeDay;
  final String? errorMessage;

  TripDetailsState copyWith({
    TripDetailsStatus? status,
    Object? trip = _unset,
    Object? generatedPlan = _unset,
    int? activeDay,
    Object? errorMessage = _unset,
  }) {
    return TripDetailsState(
      status: status ?? this.status,
      trip: identical(trip, _unset) ? this.trip : trip as Trip?,
      generatedPlan: identical(generatedPlan, _unset)
          ? this.generatedPlan
          : generatedPlan as GeneratedPlanEntity?,
      activeDay: activeDay ?? this.activeDay,
      errorMessage: identical(errorMessage, _unset)
          ? this.errorMessage
          : errorMessage as String?,
    );
  }
}
