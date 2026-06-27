import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/trips/domain/repositories/trip_repository.dart';
import 'package:dio/dio.dart';

class RenameTripUseCase {
  final TripRepository repository;

  RenameTripUseCase(this.repository);

  Future<Result<Trip>> call(String id, String title, {CancelToken? cancelToken}) {
    return repository.renameTrip(id, title, cancelToken: cancelToken);
  }
}
