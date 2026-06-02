import 'package:mindtrip/features/ai_planner/domain/entities/time_slot.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip_itinerary.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/trip_repository.dart';

class MovePlaceBetweenTripsUseCase {
  final TripRepository repo;
  
  MovePlaceBetweenTripsUseCase(this.repo);

  Future<(TripItinerary source, TripItinerary target)> call({
    required String sourceTripId,
    required String targetTripId,
    required String placeId,
    required int toDayNumber,
    required DayPeriod toPeriod,
  }) async => repo.movePlaceBetweenTrips(
    sourceTripId: sourceTripId,
    targetTripId: targetTripId,
    placeId: placeId,
    toDayNumber: toDayNumber,
    toPeriod: toPeriod,
  );
}
