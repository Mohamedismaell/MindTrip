import 'package:dio/dio.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/ai_planner/data/models/edit_plan_request_model.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/edit_plan_response_entity.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/ai_planner_repository.dart';

class EditPlanUseCase {
  final AiPlannerRepository _repository;

  EditPlanUseCase({required AiPlannerRepository repository})
    : _repository = repository;

  Future<Result<EditPlanResponseEntity>> call({
    required EditPlanRequestModel request,
    CancelToken? cancelToken,
  }) async {
    return await _repository.editPlan(
      request: request,
      cancelToken: cancelToken,
    );
  }
}
