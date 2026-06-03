import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/time_slot.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip_itinerary.dart';

abstract class TripRepository {
  Future<Result<List<Trip>>> getAllTrips();
  Future<Result<Trip?>> getTripById(String id);
  Future<Result<void>> saveTrip(Trip trip);
  Future<Result<void>> deleteTrip(String id);
  Future<Result<void>> updateTrip(Trip trip);
  Future<Result<TripItinerary>> generateItinerary(Trip trip);
  Future<Result<TripItinerary?>> getItinerary(String tripId);
  Future<Result<void>> saveItinerary(TripItinerary itinerary);

  // Add-to-Trip UI check methods
  Future<Result<Trip?>> getTripContainingPlace(String placeId);
  Future<Result<bool>> isPlaceInAnyTrip(String placeId);

  // Itinerary mutations
  Future<Result<TripItinerary>> addPlace(
    String tripId,
    PlaceEntity place, {
    int? dayNumber,
    DayPeriod? period,
  });

  Future<Result<TripItinerary>> removePlace(String tripId, String placeId);

  Future<Result<TripItinerary>> movePlace(
    String tripId,
    String placeId,
    int toDayNumber,
    DayPeriod toPeriod,
  );

  Future<Result<(TripItinerary, TripItinerary)>> movePlaceBetweenTrips({
    required String sourceTripId,
    required String targetTripId,
    required String placeId,
    required int toDayNumber,
    required DayPeriod toPeriod,
  });
}
