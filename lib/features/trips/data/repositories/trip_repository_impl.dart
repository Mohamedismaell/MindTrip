import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/database/api/api_error_mapper.dart';
import 'package:mindtrip/features/trips/data/datasources/trip_local_datasource.dart';
import 'package:mindtrip/features/trips/data/datasources/remote_trip_datasource.dart';
import 'package:mindtrip/features/trips/data/models/create_trip_request_model.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/trips/domain/repositories/trip_repository.dart';
import 'package:mindtrip/features/trips/data/mapper/trip_mapper.dart';

class TripRepositoryImpl implements TripRepository {
  final TripLocalDataSource _localDataSource;
  final RemoteTripDataSource _remoteDataSource;

  const TripRepositoryImpl(this._localDataSource, this._remoteDataSource);

  @override
  Future<Result<List<Trip>>> getAllTrips() async {
    try {
      try {
        final remoteTrips = await _remoteDataSource.getAllTrips();
        for (final trip in remoteTrips) {
          await _localDataSource.save(trip.toModel());
        }
      } catch (_) {
        // If remote fails, we just continue with local data
      }

      final models = await _localDataSource.getAll();
      return Result.ok(models.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<Trip?>> getTripById(String id) async {
    try {
      final model = await _localDataSource.getById(id);
      return Result.ok(model?.toEntity());
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<void>> saveTrip(Trip trip) async {
    try {
      final model = trip.toModel();
      await _localDataSource.save(model);
      return const Result.ok(null);
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<void>> updateTrip(Trip trip) async {
    try {
      final model = trip.toModel();
      await _localDataSource.save(model);
      return const Result.ok(null);
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<void>> deleteTrip(String id) async {
    try {
      await _localDataSource.delete(id);
      return const Result.ok(null);
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<Trip>> createTrip(CreateTripRequestModel request) async {
    try {
      final savedTrip = await _remoteDataSource.createTrip(request);
      final model = savedTrip.toModel();
      await _localDataSource.save(model);
      return Result.ok(savedTrip);
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<void>> updateTripStatus(String tripId, String status) async {
    try {
      final tripOpt = await getTripById(tripId);
      final trip = tripOpt.when(
        success: (t) => t,
        failure: (_) => null,
        cancelled: () => null,
      );
      if (trip != null) {
        await _remoteDataSource.updateTripStatus(trip.tripId, status);
        final statusEnum = TripStatus.values.firstWhere(
          (e) => e.name.toLowerCase() == status.toLowerCase(),
          orElse: () => trip.status,
        );
        //Todo check

        final updated = trip;
        await saveTrip(updated);
      }
      return const Result.ok(null);
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<bool>> isPlaceInAnyTrip(String placeId) async {
    try {
      final tripsResult = await getAllTrips();
      return tripsResult.when(
        success: (trips) {
          for (final trip in trips) {
            // if (_containsPlace(trip, placeId)) {
            // return Result.ok(true);
            // }
          }
          return const Result.ok(false);
        },
        failure: (error) => Result.error(error),
        cancelled: () => const Result.cancelled(),
      );
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  // // Helpers
  // bool _containsPlace(Trip trip, String placeId) {
  //   if (trip.collected == null ) return false;
  //   try {
  //     final planData = jsonDecode(trip.collectedJson!);
  //     final plan = GeneratedPlanModel.fromJson(planData);

  //     for (final place in plan.plan?.accommodation ?? []) {
  //       if (place.placeId == placeId) return true;
  //     }
  //     for (final day in (plan.plan?.days ?? {}).values) {
  //       if (day.allPlaces.any((p) => p.placeId == placeId)) return true;
  //     }
  //     return false;
  //   } catch (_) {
  //     return false;
  //   }
  // }
}
