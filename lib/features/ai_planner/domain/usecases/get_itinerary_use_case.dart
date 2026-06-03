import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip_itinerary.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/trip_repository.dart';

class GetItineraryUseCase {
  final TripRepository repository;

  GetItineraryUseCase(this.repository);

  Future<Result<TripItinerary?>> call(String tripId) async {
    return repository.getItinerary(tripId);
  }
}
