import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/trips/domain/repositories/trip_repository.dart';

class DeleteTripUseCase {
  final TripRepository _repository;

  DeleteTripUseCase(this._repository);

  Future<Result<void>> call(String id) async {
    return _repository.deleteTrip(id);
  }
}
