import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/ai_planner/data/models/generate_plan_request_model.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/ai_planner_repository.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/generated_plan_entity.dart';

class GeneratePlanUseCase {
  final AiPlannerRepository repository;

  GeneratePlanUseCase(this.repository);

  Future<Result<GeneratedPlanEntity>> call({
    required GeneratePlanRequestModel request,
  }) {
    return repository.generateItinerary(request: request);
  }
}
