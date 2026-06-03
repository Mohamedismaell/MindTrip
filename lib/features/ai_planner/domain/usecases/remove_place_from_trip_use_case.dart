import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip_itinerary.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/trip_repository.dart';

class RemovePlaceFromTripUseCase {
  final TripRepository repo;

  RemovePlaceFromTripUseCase(this.repo);

  Future<Result<TripItinerary>> call({
    required String tripId,
    required String placeId,
  }) async => repo.removePlace(tripId, placeId);
}
