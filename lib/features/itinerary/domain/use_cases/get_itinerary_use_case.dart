import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/itinerary/domain/entities/trip_itinerary.dart';
import 'package:mindtrip/features/itinerary/domain/repositories/itinerary_repository.dart';

class GetItineraryUseCase {
  final ItineraryRepository repository;

  GetItineraryUseCase(this.repository);

  Future<Result<TripItinerary?>> call(String tripId) async {
    return repository.getItinerary(tripId);
  }
}
