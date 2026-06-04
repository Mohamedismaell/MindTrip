import 'package:mindtrip/core/database/cache/app_hive.dart';
import 'package:mindtrip/features/ai_planner/data/models/planning_session_model.dart';

class PlanningSessionLocalDataSource {
  Future<void> save(PlanningSessionModel session) async {
    final box = AppHive.planningSessionsBox;
    final existing = box.get(session.id);
    if (existing != null) {
      final existingModel = PlanningSessionModel.fromJson(
        Map<String, dynamic>.from(existing),
      );
      if (existingModel.updatedAt.isAfter(session.updatedAt)) {
        // Stale write — stored session is newer, skip.
        return;
      }
    }
    await box.put(session.id, session.toJson());
  }

  Future<PlanningSessionModel?> getById(String id) async {
    final box = AppHive.planningSessionsBox;
    final data = box.get(id);
    if (data == null) return null;
    return PlanningSessionModel.fromJson(Map<String, dynamic>.from(data));
  }

  Future<void> delete(String id) async {
    final box = AppHive.planningSessionsBox;
    await box.delete(id);
  }
}
