import 'package:dio/dio.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/database/api/api_error_mapper.dart';
import 'package:mindtrip/features/ai_planner/data/datasources/ai_planner_remote_datasource.dart';
import 'package:mindtrip/features/ai_planner/data/models/generate_plan_request_model.dart';
import 'package:mindtrip/features/ai_planner/data/models/edit_plan_request_model.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/ai_planner_repository.dart';
import 'package:mindtrip/features/ai_planner/data/mapper/generated_plan_mapper.dart';
import 'package:mindtrip/features/ai_planner/data/mapper/edit_plan_mapper.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/generated_plan_entity.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/edit_plan_response_entity.dart';

class AiPlannerRepositoryImpl implements AiPlannerRepository {
  AiPlannerRepositoryImpl({required AiPlannerRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final AiPlannerRemoteDataSource _remoteDataSource;

  @override
  Future<Result<GeneratedPlanEntity>> generateItinerary({
    required GeneratePlanRequestModel request,
    CancelToken? cancelToken,
  }) async {
    try {
      final result = await _remoteDataSource.generate(
        request: request,
        cancelToken: cancelToken,
      );
      return Result.ok(result.toEntity());
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

  @override
  Future<Result<EditPlanResponseEntity>> editPlan({
    required EditPlanRequestModel request,
    CancelToken? cancelToken,
  }) async {
    try {
      final result = await _remoteDataSource.edit(
        request: request,
        cancelToken: cancelToken,
      );
      return Result.ok(result.toEntity());
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

