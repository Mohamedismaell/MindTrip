import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/trips/domain/repositories/trip_repository.dart';

class GetTripByIdUseCase {
  final TripRepository _repository;

  GetTripByIdUseCase(this._repository);

  Future<Result<Trip?>> call(String id) async {
    return _repository.getTripById(id);
  }
}
