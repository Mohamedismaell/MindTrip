import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/database/api/api_error_mapper.dart';
import 'package:mindtrip/features/home/data/mapper/banner_mapper.dart';
import 'package:mindtrip/core/shared/data/mapper/planner_preview_mapper.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/planner_preview_entity.dart';
import 'package:mindtrip/features/home/data/datasources/home_local_data_source.dart';
import 'package:mindtrip/features/home/data/datasources/home_remote_data_source.dart';
import 'package:mindtrip/features/home/domain/entity/banner_entity.dart';
import 'package:mindtrip/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;

  HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Result<List<BannerEntity>>> getBanners() async {
    try {
      final remoteBanners = await remoteDataSource.getBanners();
      await localDataSource.cacheBanners(remoteBanners);
      return Result.ok(remoteBanners.map((m) => m.toEntity()).toList());
    } catch (e) {
      try {
        final localBanners = await localDataSource.getBanners();
        if (localBanners.isNotEmpty) {
          return Result.ok(localBanners.map((m) => m.toEntity()).toList());
        }
      } catch (_) {
        // Fallback to original remote error if local fails too
      }
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<List<PlannerPreviewEntity>>> getPlannerPreviews() async {
    try {
      final remotePreviews = await remoteDataSource.getPlannerPreviews();
      await localDataSource.cachePlannerPreviews(remotePreviews);
      return Result.ok(remotePreviews.map((m) => m.toEntity()).toList());
    } catch (e) {
      try {
        final localPreviews = await localDataSource.getPlannerPreviews();
        if (localPreviews.isNotEmpty) {
          return Result.ok(localPreviews.map((m) => m.toEntity()).toList());
        }
      } catch (_) {
        // Fallback to original remote error if local fails too
      }
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }
}
