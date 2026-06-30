import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/trips/domain/repositories/trip_repository.dart';
import 'package:dio/dio.dart';

class DeleteReviewUseCase {
  final TripRepository repository;

  DeleteReviewUseCase(this.repository);

  Future<Result<void>> call(
    String id, {
    CancelToken? cancelToken,
  }) {
    return repository.deleteReview(
      id,
      cancelToken: cancelToken,
    );
  }
}
