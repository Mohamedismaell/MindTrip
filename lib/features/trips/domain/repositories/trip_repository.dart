import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/data/models/generated_plan_model.dart';

abstract class TripRepository {
  // Future<Result<List<Trip>>> getAllTrips();
  // // Future<Result<Trip?>> getTripById(String id);
  // // Future<Result<void>> saveTrip(Trip trip);
  // // Future<Result<void>> deleteTrip(String id);
  // // Future<Result<void>> updateTrip(Trip trip);

  // // New backend actions
  // Future<Result<Trip>> createTrip(Trip trip, GeneratedPlanModel plan);
  // // Future<Result<void>> confirmTrip(String tripId);
  // // Future<Result<void>> updateTripStatus(String tripId, String status);

  // // Add-to-Trip UI check methods
  // // Future<Result<Trip?>> getTripContainingPlace(String placeId);
  // Future<Result<bool>> isPlaceInAnyTrip(String placeId);
}
