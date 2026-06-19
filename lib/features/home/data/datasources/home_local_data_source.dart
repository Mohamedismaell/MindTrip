import 'package:hive_ce_flutter/adapters.dart';
import 'package:mindtrip/core/shared/data/models/banner_model.dart';
import 'package:mindtrip/core/shared/data/models/planner_preview_model.dart';

abstract class HomeLocalDataSource {
  Future<List<BannerModel>> getBanners();
  Future<void> cacheBanners(List<BannerModel> banners);
  
  Future<List<PlannerPreviewModel>> getPlannerPreviews();
  Future<void> cachePlannerPreviews(List<PlannerPreviewModel> previews);
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final Box<BannerModel> _bannersBox;
  final Box<PlannerPreviewModel> _plannerPreviewsBox;

  HomeLocalDataSourceImpl({
    required Box<BannerModel> bannersBox,
    required Box<PlannerPreviewModel> plannerPreviewsBox,
  })  : _bannersBox = bannersBox,
        _plannerPreviewsBox = plannerPreviewsBox;

  @override
  Future<List<BannerModel>> getBanners() async {
    return _bannersBox.values.toList();
  }

  @override
  Future<void> cacheBanners(List<BannerModel> banners) async {
    await _bannersBox.clear();
    await _bannersBox.addAll(banners);
  }

  @override
  Future<List<PlannerPreviewModel>> getPlannerPreviews() async {
    return _plannerPreviewsBox.values.toList();
  }

  @override
  Future<void> cachePlannerPreviews(List<PlannerPreviewModel> previews) async {
    await _plannerPreviewsBox.clear();
    await _plannerPreviewsBox.addAll(previews);
  }
}
