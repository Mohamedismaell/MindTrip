import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/trips/data/models/update_trip_plan_request_model.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/trips/domain/repositories/trip_repository.dart';
import 'package:dio/dio.dart';

class UpdateTripPlanUseCase {
  final TripRepository repository;

  UpdateTripPlanUseCase(this.repository);

  Future<Result<Trip>> call(
    String id,
    UpdateTripPlanRequestModel request, {
    CancelToken? cancelToken,
  }) {
    return repository.updateTripPlan(id, request, cancelToken: cancelToken);
  }
}
