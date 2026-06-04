import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/itinerary/domain/entities/time_slot.dart';
import 'package:mindtrip/features/itinerary/domain/entities/trip_itinerary.dart';
import 'package:mindtrip/features/itinerary/domain/repositories/itinerary_repository.dart';

class MovePlaceBetweenTripsUseCase {
  final ItineraryRepository repo;

  MovePlaceBetweenTripsUseCase(this.repo);

  Future<Result<(TripItinerary source, TripItinerary target)>> call({
    required String sourceTripId,
    required String targetTripId,
    required String placeId,
    required int toDayNumber,
    required PlaceDayPeriod toPeriod,
  }) async => repo.movePlaceBetweenTrips(
    sourceTripId: sourceTripId,
    targetTripId: targetTripId,
    placeId: placeId,
    toDayNumber: toDayNumber,
    toPeriod: toPeriod,
  );
}
