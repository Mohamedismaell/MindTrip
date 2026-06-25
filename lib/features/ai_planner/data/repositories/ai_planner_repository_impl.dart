import 'package:dio/dio.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/database/api/api_error_mapper.dart';
import 'package:mindtrip/features/ai_planner/data/datasources/ai_planner_remote_datasource.dart';
import 'package:mindtrip/features/ai_planner/data/models/generate_plan_request_model.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/ai_planner_repository.dart';
import 'package:mindtrip/features/ai_planner/data/mapper/generated_plan_mapper.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/generated_plan_entity.dart';

class AiPlannerRepositoryImpl implements AiPlannerRepository {
  AiPlannerRepositoryImpl({required AiPlannerRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  // final AiPlannerLocalDataSource _localDataSource;
  final AiPlannerRemoteDataSource _remoteDataSource;
  @override
  Future<Result<GeneratedPlanEntity>> generateItinerary({
    required GeneratePlanRequestModel request,
    CancelToken? cancelToken,
  }) async {
    try {
      final model = await _remoteDataSource.generate(
        request: request,
        cancelToken: cancelToken,
      );
      return Result.ok(model.toEntity());
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        return const Result.cancelled();
      } else {
        return Result.error(ApiErrorMapper.fromException(e));
      }
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }
}
