import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/trip_repository.dart';

class SaveTripUseCase {
  final TripRepository _repository;

  SaveTripUseCase(this._repository);

  Future<Result<void>> call(Trip trip) async {
    return _repository.saveTrip(trip);
  }
}
