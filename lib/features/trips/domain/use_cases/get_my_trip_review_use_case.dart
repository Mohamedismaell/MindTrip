import 'package:dio/dio.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/trips/domain/repositories/trip_repository.dart';

class GetMyTripReviewUseCase {
  final TripRepository repository;

  GetMyTripReviewUseCase(this.repository);

  Future<Result<bool>> call(String tripId, {CancelToken? cancelToken}) {
    return repository.getMyTripReview(tripId, cancelToken: cancelToken);
  }
}
