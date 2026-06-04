import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/planning_session_repository.dart';

class DeletePlanningSessionUseCase {
  final PlanningSessionRepository _repository;

  DeletePlanningSessionUseCase(this._repository);

  Future<Result<void>> call(String tripId) {
    return _repository.deleteSession(tripId);
  }
}
