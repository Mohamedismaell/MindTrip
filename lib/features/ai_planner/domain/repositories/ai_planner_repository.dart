import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/ai_planner/data/models/generate_plan_request_model.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/generated_plan_entity.dart';

abstract class AiPlannerRepository {
  Future<Result<GeneratedPlanEntity>> generateItinerary({
    required GeneratePlanRequestModel request,
  });
}
