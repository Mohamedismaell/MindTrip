import 'package:mindtrip/features/ai_planner/domain/entities/generated_plan_entity.dart';

class TripDetailsArgs {
  final String? tripId;
  final GeneratedPlanEntity? generatedPlan;

  const TripDetailsArgs({
    this.tripId,
    this.generatedPlan,
  }) : assert(tripId != null || generatedPlan != null,
            'Either tripId or generatedPlan must be provided');
}
