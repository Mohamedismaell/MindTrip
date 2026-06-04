import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/planning_session.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/planning_session_repository.dart';

class GetPlanningSessionUseCase {
  final PlanningSessionRepository _repository;

  GetPlanningSessionUseCase(this._repository);

  Future<Result<PlanningSession?>> call(String tripId) {
    return _repository.getSession(tripId);
  }
}
