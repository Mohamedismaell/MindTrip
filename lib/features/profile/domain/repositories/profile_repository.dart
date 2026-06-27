import 'package:dio/dio.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/profile/domain/entities/trip_review_entity.dart';

abstract class ProfileRepository {
  Future<Result<void>> deleteAccount({CancelToken? cancelToken});
  Future<Result<List<TripReviewEntity>>> getMyReviews({
    CancelToken? cancelToken,
  });
}
