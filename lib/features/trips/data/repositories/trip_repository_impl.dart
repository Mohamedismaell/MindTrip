import 'dart:convert';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/database/api/api_error_mapper.dart';
import 'package:mindtrip/features/trips/data/datasources/trip_local_datasource.dart';
import 'package:mindtrip/features/trips/data/datasources/remote_trip_datasource.dart';
import 'package:mindtrip/features/trips/data/models/trip_model.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/trips/domain/repositories/trip_repository.dart';
import 'package:mindtrip/features/ai_planner/data/models/generated_plan_model.dart';

class TripRepositoryImpl implements TripRepository {
  // final TripLocalDataSource _localDataSource;
  final RemoteTripDataSource _remoteDataSource;

  const TripRepositoryImpl(this._remoteDataSource);

  // @override
  // Future<Result<List<Trip>>> getAllTrips() async {
  //   try {
  //     // Try to sync with remote first
  //     try {
  //       final remoteTrips = await _remoteDataSource.getAllTrips();
  //       // for (final trip in remoteTrips) {
  //       //   await _localDataSource.save(TripModel.fromEntity(trip));
  //       // }
  //     } catch (_) {
  //       // If remote fails, we just continue with local data
  //     }

  //     // final models = await _localDataSource.getAll();
  //     // return Result.ok(models.map((e) => e.toEntity()).toList());
  //   } catch (e) {
  //     return Result.error(ApiErrorMapper.fromException(e));
  //   }
  // }

  // @override
  // Future<Result<Trip?>> getTripById(String id) async {
  //   try {
  //     final model = await _localDataSource.getById(id);
  //     return Result.ok(model?.toEntity());
  //   } catch (e) {
  //     return Result.error(ApiErrorMapper.fromException(e));
  //   }
  // }

  // @override
  // Future<Result<void>> saveTrip(Trip trip) async {
  //   try {
  //     final model = TripModel.fromEntity(trip);
  //     await _localDataSource.save(model);
  //     return const Result.ok(null);
  //   } catch (e) {
  //     return Result.error(ApiErrorMapper.fromException(e));
  //   }
  // }

  // @override
  // Future<Result<void>> updateTrip(Trip trip) async {
  //   try {
  //     final model = TripModel.fromEntity(trip);
  //     await _localDataSource.save(model);
  //     return const Result.ok(null);
  //   } catch (e) {
  //     return Result.error(ApiErrorMapper.fromException(e));
  //   }
  // }

  // @override
  // Future<Result<void>> deleteTrip(String id) async {
  //   try {
  //     await _localDataSource.delete(id);
  //     return const Result.ok(null);
  //   } catch (e) {
  //     return Result.error(ApiErrorMapper.fromException(e));
  //   }
  // }

  // @override
  // Future<Result<Trip>> createTrip(Trip trip, GeneratedPlanModel plan) async {
  //   try {
  //     final updatedTrip = await _remoteDataSource.createTrip(trip, plan);
  //     final model = TripModel.fromEntity(updatedTrip);
  //     await _localDataSource.save(model);
  //     return Result.ok(updatedTrip);
  //   } catch (e) {
  //     return Result.error(ApiErrorMapper.fromException(e));
  //   }
  // }

  // @override
  // Future<Result<void>> confirmTrip(String tripId) async {
  //   try {
  //     final tripOpt = await getTripById(tripId);
  //     final trip = tripOpt.when(
  //       success: (t) => t,
  //       failure: (_) => null,
  //       cancelled: () => null,
  //     );
  //     if (trip != null && trip.backendTripId != null) {
  //       await _remoteDataSource.confirmTrip(trip.backendTripId!);
  //       final updated = trip.copyWith(status: TripStatus.upcoming);
  //       await saveTrip(updated);
  //     }
  //     return const Result.ok(null);
  //   } catch (e) {
  //     return Result.error(ApiErrorMapper.fromException(e));
  //   }
  // }

  // @override
  // Future<Result<void>> updateTripStatus(String tripId, String status) async {
  //   try {
  //     final tripOpt = await getTripById(tripId);
  //     final trip = tripOpt.when(
  //       success: (t) => t,
  //       failure: (_) => null,
  //       cancelled: () => null,
  //     );
  //     if (trip != null && trip.backendTripId != null) {
  //       await _remoteDataSource.updateTripStatus(trip.backendTripId!, status);
  //       final statusEnum = TripStatus.values.firstWhere(
  //         (e) => e.name.toLowerCase() == status.toLowerCase(),
  //         orElse: () => trip.status,
  //       );
  //       final updated = trip.copyWith(status: statusEnum);
  //       await saveTrip(updated);
  //     }
  //     return const Result.ok(null);
  //   } catch (e) {
  //     return Result.error(ApiErrorMapper.fromException(e));
  //   }
  // }

  // @override
  // Future<Result<Trip?>> getTripContainingPlace(String placeId) async {
  //   try {
  //     final tripsResult = await getAllTrips();
  //     return tripsResult.when(
  //       success: (trips) {
  //         for (final trip in trips) {
  //           if (_containsPlace(trip, placeId)) {
  //             return Result.ok(trip);
  //           }
  //         }
  //         return const Result.ok(null);
  //       },
  //       failure: (error) => Result.error(error),
  //       cancelled: () => const Result.cancelled(),
  //     );
  //   } catch (e) {
  //     return Result.error(ApiErrorMapper.fromException(e));
  //   }
  // }

  // @override
  // Future<Result<bool>> isPlaceInAnyTrip(String placeId) async {
  //   final result = await getTripContainingPlace(placeId);
  //   return result.when(
  //     success: (trip) => Result.ok(trip != null),
  //     failure: (error) => Result.error(error),
  //     cancelled: () => const Result.cancelled(),
  //   );
  // }

  // // Helpers
  // bool _containsPlace(Trip trip, String placeId) {
  //   if (trip.planJson == null || trip.planJson!.isEmpty) return false;
  //   try {
  //     final planData = jsonDecode(trip.planJson!);
  //     final plan = GeneratedPlanModel.fromJson(planData);

  //     for (final place in plan.accommodation) {
  //       if (place.placeId == placeId) return true;
  //     }
  //     for (final day in plan.days.values) {
  //       if (day.allPlaces.any((p) => p.placeId == placeId)) return true;
  //     }
  //     return false;
  //   } catch (_) {
  //     return false;
  //   }
  // }
}
