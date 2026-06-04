import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';

abstract class TripRepository {
  Future<Result<List<Trip>>> getAllTrips();
  Future<Result<Trip?>> getTripById(String id);
  Future<Result<void>> saveTrip(Trip trip);
  Future<Result<void>> deleteTrip(String id);
  Future<Result<void>> updateTrip(Trip trip);

  // Add-to-Trip UI check methods
  Future<Result<Trip?>> getTripContainingPlace(String placeId);
  Future<Result<bool>> isPlaceInAnyTrip(String placeId);
}
