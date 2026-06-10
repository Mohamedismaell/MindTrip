import 'package:mindtrip/core/shared/domain/entities/banner_entity.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/planner_preview_entity.dart';
import 'package:mindtrip/features/home/presentation/data/home_mock_data.dart';

abstract class HomeLocalDataSource {
  Future<List<BannerEntity>> getBanners();
  Future<List<PlannerPreviewEntity>> getPlannerPreviews();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  @override
  Future<List<BannerEntity>> getBanners() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return HomeMockData.banners;
  }

  @override
  Future<List<PlannerPreviewEntity>> getPlannerPreviews() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    return HomeMockData.plannerPreviews
        .map((preview) => PlannerPreviewEntity(
              title: preview.title,
              imageUrl: preview.imageUrl,
              badge: preview.badge,
              stops: preview.stops
                  .map((stop) => PlannerStopEntity(
                        time: stop.time,
                        label: stop.label,
                      ))
                  .toList(),
            ))
        .toList();
  }
}
