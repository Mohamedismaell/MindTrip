import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/trips/domain/repositories/trip_repository.dart';

class UpdateTripUseCase {
  final TripRepository _repository;

  UpdateTripUseCase(this._repository);

  Future<Result<void>> call(Trip trip) async {
    return _repository.updateTrip(trip);
  }
}
