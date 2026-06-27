import 'package:dio/dio.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/database/api/api_error_mapper.dart';
import 'package:mindtrip/features/profile/data/datasources/profile_local_datasource.dart';
import 'package:mindtrip/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:mindtrip/features/profile/data/mapper/trip_review_mapper.dart';
import 'package:mindtrip/features/profile/data/models/trip_review_model.dart';
import 'package:mindtrip/features/profile/domain/entities/trip_review_entity.dart';
import 'package:mindtrip/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource _remoteDatasource;
  final ProfileLocalDatasource _localDatasource;

  ProfileRepositoryImpl({
    required ProfileRemoteDatasource remoteDatasource,
    required ProfileLocalDatasource localDatasource,
  }) : _remoteDatasource = remoteDatasource,
       _localDatasource = localDatasource;

  @override
  Future<Result<void>> deleteAccount({CancelToken? cancelToken}) async {
    try {
      await _remoteDatasource.deleteAccount(cancelToken: cancelToken);
      return const Result.ok(null);
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        return const Result.cancelled();
      }
      return Result.error(ApiErrorMapper.fromException(e));
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<List<TripReviewEntity>>> getMyReviews({
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _remoteDatasource.getMyReviews(
        cancelToken: cancelToken,
      );

      await _localDatasource.clearMyReviews();
      await _localDatasource.saveMyReviews(response);

      final reviews = response
          .map((e) => TripReviewModel.fromJson(e).toEntity())
          .toList();
      return Result.ok(reviews);
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        return const Result.cancelled();
      }

      // If remote fetch fails, try falling back to local cache
      final cachedReviews = await _localDatasource.getMyReviews();
      if (cachedReviews != null && cachedReviews.isNotEmpty) {
        return Result.ok(cachedReviews.map((e) => e.toEntity()).toList());
      }

      return Result.error(ApiErrorMapper.fromException(e));
    } catch (e) {
      // If any other error occurs, try falling back to local cache
      final cachedReviews = await _localDatasource.getMyReviews();
      if (cachedReviews != null && cachedReviews.isNotEmpty) {
        return Result.ok(cachedReviews.map((e) => e.toEntity()).toList());
      }

      return Result.error(ApiErrorMapper.fromException(e));
    }
  }
}
