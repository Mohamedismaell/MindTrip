import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/planning_session.dart';

abstract class PlanningSessionRepository {
  Future<Result<PlanningSession?>> getSession(String tripId);
  Future<Result<void>> saveSession(PlanningSession session);
  Future<Result<void>> deleteSession(String tripId);
}
