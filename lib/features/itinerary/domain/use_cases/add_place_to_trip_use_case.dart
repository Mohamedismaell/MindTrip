import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/features/itinerary/domain/entities/time_slot.dart';
import 'package:mindtrip/features/itinerary/domain/entities/trip_itinerary.dart';
import 'package:mindtrip/features/itinerary/domain/repositories/itinerary_repository.dart';

class AddPlaceToTripUseCase {
  final ItineraryRepository repo;

  AddPlaceToTripUseCase(this.repo);

  Future<Result<TripItinerary>> call({
    required String tripId,
    required PlaceEntity place,
    int? dayNumber,
    PlaceDayPeriod? period,
  }) async =>
      repo.addPlace(tripId, place, dayNumber: dayNumber, period: period);
}
