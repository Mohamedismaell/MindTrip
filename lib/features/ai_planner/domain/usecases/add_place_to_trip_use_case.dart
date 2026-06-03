import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/time_slot.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip_itinerary.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/trip_repository.dart';

class AddPlaceToTripUseCase {
  final TripRepository repo;

  AddPlaceToTripUseCase(this.repo);

  Future<Result<TripItinerary>> call({
    required String tripId,
    required PlaceEntity place,
    int? dayNumber,
    DayPeriod? period,
  }) async =>
      repo.addPlace(tripId, place, dayNumber: dayNumber, period: period);
}
