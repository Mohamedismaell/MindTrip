import 'package:mindtrip/features/ai_planner/domain/entities/generated_plan_entity.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';

enum TripDetailsStatus { initial, loading, loaded, error }

enum TripDetailsActionStatus { idle, loading, success, error }

class TripDetailsState {
  const TripDetailsState({
    this.status = TripDetailsStatus.initial,
    this.trip,
    this.generatedPlan,
    this.activeDay = 1,
    this.errorMessage,
    this.checkedPlaces = const {},
    this.actionStatus = TripDetailsActionStatus.idle,
    this.actionError,
    this.hasReviewed = true,
  });

  static const _unset = Object();

  final TripDetailsStatus status;
  final Trip? trip;
  final GeneratedPlanEntity? generatedPlan;
  final int activeDay;
  final String? errorMessage;
  final Set<String> checkedPlaces;
  final TripDetailsActionStatus actionStatus;
  final String? actionError;
  final bool hasReviewed;

  TripDetailsState copyWith({
    TripDetailsStatus? status,
    Object? trip = _unset,
    Object? generatedPlan = _unset,
    int? activeDay,
    Object? errorMessage = _unset,
    Set<String>? checkedPlaces,
    TripDetailsActionStatus? actionStatus,
    Object? actionError = _unset,
    bool? hasReviewed,
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
      checkedPlaces: checkedPlaces ?? this.checkedPlaces,
      actionStatus: actionStatus ?? this.actionStatus,
      actionError: identical(actionError, _unset)
          ? this.actionError
          : actionError as String?,
      hasReviewed: hasReviewed ?? this.hasReviewed,
    );
  }
}
