import 'package:mindtrip/core/database/api/api_consumer.dart';
import 'package:mindtrip/core/database/api/end_points.dart';
import 'package:mindtrip/core/shared/data/models/banner_model.dart';
import 'package:mindtrip/core/shared/data/models/planner_preview_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<BannerModel>> getBanners();
  Future<List<PlannerPreviewModel>> getPlannerPreviews();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiConsumer _api;

  HomeRemoteDataSourceImpl({required ApiConsumer api}) : _api = api;

  @override
  Future<List<BannerModel>> getBanners() async {
    final response = await _api.get(EndPoints.getBanners);
    return (response as List)
        .map((json) => BannerModel.fromJson(json))
        .toList();
  }

  @override
  Future<List<PlannerPreviewModel>> getPlannerPreviews() async {
    final response = await _api.get(EndPoints.getPlannerPreviews);
    return (response as List)
        .map((json) => PlannerPreviewModel.fromJson(json))
        .toList();
  }
}
