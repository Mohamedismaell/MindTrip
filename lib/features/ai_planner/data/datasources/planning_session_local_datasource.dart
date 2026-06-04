import 'dart:convert';
import 'package:mindtrip/core/database/cache/app_hive.dart';
import 'package:mindtrip/features/ai_planner/data/models/planning_session_model.dart';

class PlanningSessionLocalDataSource {
  Future<void> save(PlanningSessionModel session) async {
    final box = AppHive.planningSessionsBox;
    final existing = box.get(session.id);

    if (existing != null) {
      final existingModel = PlanningSessionModel.fromJson(
        jsonDecode(jsonEncode(existing)),
      );
      if (existingModel.updatedAt.isAfter(session.updatedAt)) {
        return;
      }
    }

    await box.put(session.id, session.toJson());
  }

  Future<PlanningSessionModel?> getById(String id) async {
    final data = AppHive.planningSessionsBox.get(id);
    if (data == null) return null;

    return PlanningSessionModel.fromJson(jsonDecode(jsonEncode(data)));
  }

  Future<void> delete(String id) async {
    await AppHive.planningSessionsBox.delete(id);
  }
}
