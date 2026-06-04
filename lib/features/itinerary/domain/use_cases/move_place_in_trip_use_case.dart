import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/itinerary/domain/entities/time_slot.dart';
import 'package:mindtrip/features/itinerary/domain/entities/trip_itinerary.dart';
import 'package:mindtrip/features/itinerary/domain/repositories/itinerary_repository.dart';

class MovePlaceInTripUseCase {
  final ItineraryRepository repo;

  MovePlaceInTripUseCase(this.repo);

  Future<Result<TripItinerary>> call({
    required String tripId,
    required String placeId,
    required int toDayNumber,
    required PlaceDayPeriod toPeriod,
  }) async => repo.movePlace(tripId, placeId, toDayNumber, toPeriod);
}
