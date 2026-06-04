import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/planning_session.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/planning_session_repository.dart';

class SavePlanningSessionUseCase {
  final PlanningSessionRepository _repository;

  SavePlanningSessionUseCase(this._repository);

  Future<Result<void>> call(PlanningSession session) {
    return _repository.saveSession(session);
  }
}
