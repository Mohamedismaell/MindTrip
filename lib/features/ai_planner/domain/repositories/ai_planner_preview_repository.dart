import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/planner_preview_entity.dart';

abstract class AIPlannerPreviewRepository {
  Future<Result<List<PlannerPreviewEntity>>> getPlannerPreviews();
}
