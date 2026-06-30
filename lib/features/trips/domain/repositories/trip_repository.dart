import 'package:dio/dio.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/trips/data/models/create_trip_request_model.dart';
import 'package:mindtrip/features/trips/data/models/update_trip_plan_request_model.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';

abstract class TripRepository {
  Future<Result<void>> saveTrip(Trip trip);
  Future<Result<void>> updateTrip(Trip trip);

  Future<Result<Trip>> createTrip(CreateTripRequestModel request);
  Future<Result<void>> updateTripStatus(String tripId, String status);

  Future<Result<List<Trip>>> getTrips({int? status, CancelToken? cancelToken});
  Future<Result<Trip>> getTripById(String id, {CancelToken? cancelToken});
  Future<Result<void>> deleteTrip(String id, {CancelToken? cancelToken});
  Future<Result<String>> shareTrip(String id, {CancelToken? cancelToken});
  Future<Result<Trip>> renameTrip(
    String id,
    String title, {
    CancelToken? cancelToken,
  });

  Future<Result<Trip>> changeTripStatus(
    String id,
    int status, {
    CancelToken? cancelToken,
  });
  Future<Result<void>> reviewTrip(
    String id,
    int rating,
    String? comment, {
    CancelToken? cancelToken,
  });
  Future<Result<void>> updateReview(
    String id,
    int rating,
    String? comment, {
    CancelToken? cancelToken,
  });
  Future<Result<void>> deleteReview(
    String id, {
    CancelToken? cancelToken,
  });
  Future<Result<bool>> getMyTripReview(
    String id, {
    CancelToken? cancelToken,
  });
  Future<Result<Trip>> updateTripPlan(
    String id,
    UpdateTripPlanRequestModel request, {
    CancelToken? cancelToken,
  });
  Future<Result<Trip>> getSharedTrip(String token, {CancelToken? cancelToken});
}
