import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/itinerary/domain/entities/trip_itinerary.dart';
import 'package:mindtrip/features/itinerary/domain/repositories/itinerary_repository.dart';

class SaveItineraryUseCase {
  final ItineraryRepository repository;

  SaveItineraryUseCase(this.repository);

  Future<Result<void>> call(TripItinerary itinerary) async {
    return repository.saveItinerary(itinerary);
  }
}
