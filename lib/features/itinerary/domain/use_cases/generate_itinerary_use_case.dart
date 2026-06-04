import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/itinerary/domain/entities/trip_itinerary.dart';
import 'package:mindtrip/features/itinerary/domain/repositories/itinerary_repository.dart';

class GenerateItineraryUseCase {
  final ItineraryRepository repository;

  GenerateItineraryUseCase(this.repository);

  Future<Result<TripItinerary>> call(Trip trip) {
    return repository.generateItinerary(trip);
  }
}
