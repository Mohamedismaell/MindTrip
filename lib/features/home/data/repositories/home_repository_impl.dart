import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/database/api/api_error_mapper.dart';
import 'package:mindtrip/core/shared/domain/entities/banner_entity.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/planner_preview_entity.dart';
import 'package:mindtrip/features/home/data/datasources/home_local_data_source.dart';
import 'package:mindtrip/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDataSource localDataSource;

  HomeRepositoryImpl({required this.localDataSource});

  @override
  Future<Result<List<BannerEntity>>> getBanners() async {
    try {
      final banners = await localDataSource.getBanners();
      return Result.ok(banners);
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<List<PlannerPreviewEntity>>> getPlannerPreviews() async {
    try {
      final previews = await localDataSource.getPlannerPreviews();
      return Result.ok(previews);
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }
}
