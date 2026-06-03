import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/trip_repository.dart';

class GetAllTripsUseCase {
  final TripRepository _repository;

  GetAllTripsUseCase(this._repository);

  Future<Result<List<Trip>>> call() async {
    return _repository.getAllTrips();
  }
}
