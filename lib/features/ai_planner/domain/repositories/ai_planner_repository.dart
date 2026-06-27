import 'package:dio/dio.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/ai_planner/data/models/generate_plan_request_model.dart';
import 'package:mindtrip/features/ai_planner/data/models/edit_plan_request_model.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/generated_plan_entity.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/edit_plan_response_entity.dart';

abstract class AiPlannerRepository {
  Future<Result<GeneratedPlanEntity>> generateItinerary({
    required GeneratePlanRequestModel request,
    CancelToken? cancelToken,
  });

  Future<Result<EditPlanResponseEntity>> editPlan({
    required EditPlanRequestModel request,
    CancelToken? cancelToken,
  });
}
