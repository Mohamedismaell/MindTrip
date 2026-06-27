import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/trips/domain/repositories/trip_repository.dart';
import 'package:dio/dio.dart';

class ReviewTripUseCase {
  final TripRepository repository;

  ReviewTripUseCase(this.repository);

  Future<Result<void>> call(
    String id,
    int rating,
    String? comment, {
    CancelToken? cancelToken,
  }) {
    return repository.reviewTrip(
      id,
      rating,
      comment,
      cancelToken: cancelToken,
    );
  }
}
