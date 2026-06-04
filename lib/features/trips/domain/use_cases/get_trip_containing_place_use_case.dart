import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/trips/domain/repositories/trip_repository.dart';

class GetTripContainingPlaceUseCase {
  final TripRepository repository;

  GetTripContainingPlaceUseCase(this.repository);

  Future<Result<Trip?>> call(String placeId) async {
    return repository.getTripContainingPlace(placeId);
  }
}
