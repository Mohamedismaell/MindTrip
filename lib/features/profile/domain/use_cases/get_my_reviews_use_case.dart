import 'package:dio/dio.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/profile/domain/entities/trip_review_entity.dart';
import 'package:mindtrip/features/profile/domain/repositories/profile_repository.dart';

class GetMyReviewsUseCase {
  final ProfileRepository _repository;

  GetMyReviewsUseCase({required ProfileRepository repository})
    : _repository = repository;

  Future<Result<List<TripReviewEntity>>> call({CancelToken? cancelToken}) async {
    return await _repository.getMyReviews(cancelToken: cancelToken);
  }
}
