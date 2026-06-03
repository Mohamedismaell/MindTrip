import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/trip_repository.dart';

class UpdateTripUseCase {
  final TripRepository repository;

  UpdateTripUseCase(this.repository);

  Future<Result<void>> call(Trip trip) async {
    return repository.updateTrip(trip);
  }
}
