import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip_itinerary.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/trip_repository.dart';

class GenerateItineraryUseCase {
  final TripRepository repository;

  GenerateItineraryUseCase(this.repository);

  Future<TripItinerary> call(Trip trip) {
    return repository.generateItinerary(trip);
  }
}
