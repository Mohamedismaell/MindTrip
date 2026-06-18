import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/planner_preview_entity.dart';
import 'package:mindtrip/features/home/domain/entity/banner_entity.dart';

abstract class HomeRepository {
  Future<Result<List<BannerEntity>>> getBanners();
  Future<Result<List<PlannerPreviewEntity>>> getPlannerPreviews();
}
