import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/trips/data/models/create_trip_request_model.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/trips/domain/repositories/trip_repository.dart';

class CreateTripUseCase {
  final TripRepository _repository;

  CreateTripUseCase(this._repository);

  Future<Result<Trip>> call(CreateTripRequestModel request) async {
    return _repository.createTrip(request);
  }
}
