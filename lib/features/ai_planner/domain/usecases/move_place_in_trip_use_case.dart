import 'package:mindtrip/features/ai_planner/domain/entities/time_slot.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip_itinerary.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/trip_repository.dart';

class MovePlaceInTripUseCase {
  final TripRepository repo;
  
  MovePlaceInTripUseCase(this.repo);

  Future<TripItinerary> call({
    required String tripId,
    required String placeId,
    required int toDayNumber,
    required DayPeriod toPeriod,
  }) async => repo.movePlace(tripId, placeId, toDayNumber, toPeriod);
}
