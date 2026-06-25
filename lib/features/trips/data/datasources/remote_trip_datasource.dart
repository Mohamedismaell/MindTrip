import 'dart:convert';
import 'package:mindtrip/core/database/api/api_consumer.dart';
import 'package:mindtrip/core/database/api/api_error_mapper.dart';
import 'package:mindtrip/core/database/api/dio_consumer.dart';
import 'package:mindtrip/core/database/api/end_points.dart';
import 'package:mindtrip/features/trips/data/mapper/trip_mapper.dart';
import 'package:mindtrip/features/trips/data/models/trip_model.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/data/models/generated_plan_model.dart';

abstract class RemoteTripDataSource {
  // Future<Trip> createTrip(Trip trip, GeneratedPlanModel plan);
  // Future<List<Trip>> getAllTrips();
  // Future<void> updateTripStatus(String tripId, String status);
  // Future<void> confirmTrip(String tripId);
}

class RemoteTripDataSourceImpl implements RemoteTripDataSource {
  final ApiConsumer _apiConsumer;

  RemoteTripDataSourceImpl(this._apiConsumer);

  // @override
  // Future<Trip> createTrip(Trip trip, GeneratedPlanModel plan) async {
  //   try {
  //     final requestData = {
  //       'title': trip.title,
  //       'destinationGovernorate': trip.destination,
  //       'city': trip.destination,
  //       'startDate': trip.tripStart?.toIso8601String(),
  //       'endDate': trip.tripEnd?.toIso8601String(),
  //       'people': trip.people,
  //       'totalBudgetEgp': trip.totalBudget,
  //       'budget': trip.totalBudget.toDouble(),
  //       'totalCost': trip.totalCost.toDouble(),
  //       'plan': plan.toJson()['plan'], // Send the nested plan object
  //       'collected': jsonEncode(plan.toJson()),
  //       'sessionId': trip.sessionId,
  //       'isPublic': true,
  //       'status': 0, // Draft
  //     };

  //     final response = await _apiConsumer.post(
  //       EndPoints.trips,
  //       data: requestData,
  //     );

  //     final responseData = response as Map<String, dynamic>;
  //     return TripModel.fromJson(responseData).toEntity();
  //   } catch (e) {
  //     throw ApiErrorMapper.fromException(e);
  //   }
  // }

  // @override
  // Future<List<Trip>> getAllTrips() async {
  //   try {
  //     final response = await _apiConsumer.get(EndPoints.trips);
  //     final data = response as Map<String, dynamic>;
  //     final list = data['items'] as List<dynamic>? ?? [];
  //     return list
  //         .map((e) => TripModel.fromJson(e as Map<String, dynamic>).toEntity())
  //         .toList();
  //   } catch (e) {
  //     throw ApiErrorMapper.fromException(e);
  //   }
  // }

  // @override
  // Future<void> updateTripStatus(String tripId, String status) async {
  //   try {
  //     if (_apiConsumer is DioConsumer) {
  //       // Use patch directly
  //     }
  //     throw UnimplementedError("Not implemented without DioConsumer");
  //   } catch (e) {
  //     throw ApiErrorMapper.fromException(e);
  //   }
  // }

  // @override
  // Future<void> confirmTrip(String tripId) async {
  //   try {
  //     if (_apiConsumer is DioConsumer) {
  //       await _apiConsumer.patch(EndPoints.confirmTrip(tripId));
  //     } else {
  //       // fallback
  //       await _apiConsumer.post(EndPoints.confirmTrip(tripId), data: {});
  //     }
  //   } catch (e) {
  //     throw ApiErrorMapper.fromException(e);
  //   }
  // }
}
