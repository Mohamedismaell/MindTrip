import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip_itinerary.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/trip_repository.dart';

class SaveItineraryUseCase {
  final TripRepository repository;

  SaveItineraryUseCase(this.repository);

  Future<Result<void>> call(TripItinerary itinerary) async {
    return repository.saveItinerary(itinerary);
  }
}
