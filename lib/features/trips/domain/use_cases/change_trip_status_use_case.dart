import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/trips/domain/repositories/trip_repository.dart';
import 'package:dio/dio.dart';

class ChangeTripStatusUseCase {
  final TripRepository repository;

  ChangeTripStatusUseCase(this.repository);

  Future<Result<Trip>> call(String id, int status, {CancelToken? cancelToken}) {
    return repository.changeTripStatus(id, status, cancelToken: cancelToken);
  }
}
