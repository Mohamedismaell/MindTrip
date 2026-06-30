import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/trips/domain/repositories/trip_repository.dart';
import 'package:dio/dio.dart';

class UpdateReviewUseCase {
  final TripRepository repository;

  UpdateReviewUseCase(this.repository);

  Future<Result<void>> call(
    String id,
    int rating,
    String? comment, {
    CancelToken? cancelToken,
  }) {
    return repository.updateReview(
      id,
      rating,
      comment,
      cancelToken: cancelToken,
    );
  }
}
