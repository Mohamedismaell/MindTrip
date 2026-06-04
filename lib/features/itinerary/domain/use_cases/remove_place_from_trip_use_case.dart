import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/itinerary/domain/entities/trip_itinerary.dart';
import 'package:mindtrip/features/itinerary/domain/repositories/itinerary_repository.dart';

class RemovePlaceFromTripUseCase {
  final ItineraryRepository repo;

  RemovePlaceFromTripUseCase(this.repo);

  Future<Result<TripItinerary>> call({
    required String tripId,
    required String placeId,
  }) async => repo.removePlace(tripId, placeId);
}
