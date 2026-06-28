import 'package:mindtrip/features/ai_planner/domain/entities/generated_plan_entity.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';

class MapTripExtra {
  const MapTripExtra({required this.trip, required this.generatedPlan});
  final Trip trip;
  final GeneratedPlanEntity generatedPlan;
}
