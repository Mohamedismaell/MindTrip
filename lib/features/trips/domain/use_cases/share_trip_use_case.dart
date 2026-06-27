import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/trips/domain/repositories/trip_repository.dart';
import 'package:dio/dio.dart';

class ShareTripUseCase {
  final TripRepository repository;

  ShareTripUseCase(this.repository);

  Future<Result<String>> call(String id, {CancelToken? cancelToken}) {
    return repository.shareTrip(id, cancelToken: cancelToken);
  }
}
