import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/time_slot.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip_itinerary.dart';

abstract class TripRepository {
  Future<List<Trip>> getAllTrips();
  Future<Trip?> getTripById(String id);
  Future<void> saveTrip(Trip trip);
  Future<void> deleteTrip(String id);
  Future<void> updateTrip(Trip trip);
  Future<TripItinerary> generateItinerary(Trip trip);
  Future<TripItinerary?> getItinerary(String tripId);
  Future<void> saveItinerary(TripItinerary itinerary);

  // Add-to-Trip UI check methods
  Future<Trip?> getTripContainingPlace(String placeId);
  Future<bool> isPlaceInAnyTrip(String placeId);

  // Itinerary mutations
  Future<TripItinerary> addPlace(
    String tripId,
    PlaceEntity place, {
    int? dayNumber,
    DayPeriod? period,
  });

  Future<TripItinerary> removePlace(String tripId, String placeId);

  Future<TripItinerary> movePlace(
    String tripId,
    String placeId,
    int toDayNumber,
    DayPeriod toPeriod,
  );

  Future<(TripItinerary, TripItinerary)> movePlaceBetweenTrips({
    required String sourceTripId,
    required String targetTripId,
    required String placeId,
    required int toDayNumber,
    required DayPeriod toPeriod,
  });
}
