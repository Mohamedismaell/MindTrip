import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/trips/domain/repositories/trip_repository.dart';

class GetSharedTripUseCase {
  final TripRepository repository;

  GetSharedTripUseCase(this.repository);

  Future<Result<Trip>> call(String token) {
    return repository.getSharedTrip(token);
  }
}
