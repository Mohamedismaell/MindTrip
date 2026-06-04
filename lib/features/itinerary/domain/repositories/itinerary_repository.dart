import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/features/itinerary/domain/entities/time_slot.dart';
import 'package:mindtrip/features/itinerary/domain/entities/trip_itinerary.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';

abstract class ItineraryRepository {
  Future<Result<TripItinerary>> generateItinerary(Trip trip);
  Future<Result<TripItinerary?>> getItinerary(String tripId);
  Future<Result<void>> saveItinerary(TripItinerary itinerary);

  // Itinerary mutations
  Future<Result<TripItinerary>> addPlace(
    String tripId,
    PlaceEntity place, {
    int? dayNumber,
    PlaceDayPeriod? period,
  });

  Future<Result<TripItinerary>> removePlace(String tripId, String placeId);

  Future<Result<TripItinerary>> movePlace(
    String tripId,
    String placeId,
    int toDayNumber,
    PlaceDayPeriod toPeriod,
  );

  Future<Result<(TripItinerary, TripItinerary)>> movePlaceBetweenTrips({
    required String sourceTripId,
    required String targetTripId,
    required String placeId,
    required int toDayNumber,
    required PlaceDayPeriod toPeriod,
  });
}
