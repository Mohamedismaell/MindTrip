import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/trips/data/models/create_trip_request_model.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';

abstract class TripRepository {
  Future<Result<List<Trip>>> getAllTrips();
  Future<Result<Trip?>> getTripById(String id);
  Future<Result<void>> saveTrip(Trip trip);
  Future<Result<void>> deleteTrip(String id);
  Future<Result<void>> updateTrip(Trip trip);

  Future<Result<Trip>> createTrip(CreateTripRequestModel request);
  Future<Result<void>> updateTripStatus(String tripId, String status);

  // Add-to-Trip UI check methods
  Future<Result<bool>> isPlaceInAnyTrip(String placeId);
}
