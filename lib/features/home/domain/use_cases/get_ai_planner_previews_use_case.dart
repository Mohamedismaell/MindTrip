import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/planner_preview_entity.dart';
import 'package:mindtrip/features/home/domain/repositories/home_repository.dart';

class GetAIPlannerPreviewsUseCase {
  final HomeRepository repository;

  GetAIPlannerPreviewsUseCase({required this.repository});

  Future<Result<List<PlannerPreviewEntity>>> call() async {
    return await repository.getPlannerPreviews();
  }
}
