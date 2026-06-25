import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/trips/domain/repositories/trip_repository.dart';

class GetTripContainingPlaceUseCase {
  final TripRepository _repository;

  GetTripContainingPlaceUseCase(this._repository);

  Future<Result<bool>> call(String placeId) async {
    return _repository.isPlaceInAnyTrip(placeId);
  }
}
