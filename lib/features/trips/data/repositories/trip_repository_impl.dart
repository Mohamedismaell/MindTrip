import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/database/api/api_error_mapper.dart';
import 'package:mindtrip/features/trips/data/datasources/trip_local_datasource.dart';
import 'package:mindtrip/features/trips/data/models/trip_model.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/trips/domain/repositories/trip_repository.dart';
import 'package:mindtrip/features/itinerary/domain/repositories/itinerary_repository.dart';
import 'package:mindtrip/features/itinerary/domain/entities/trip_itinerary.dart';

class TripRepositoryImpl implements TripRepository {
  final TripLocalDataSource _localDataSource;
  final ItineraryRepository _itineraryRepository;

  const TripRepositoryImpl(this._localDataSource, this._itineraryRepository);

  @override
  Future<Result<List<Trip>>> getAllTrips() async {
    try {
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
      final model = TripModel.fromEntity(trip);
      await _localDataSource.save(model);
      return const Result.ok(null);
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<void>> updateTrip(Trip trip) async {
    try {
      final model = TripModel.fromEntity(trip);
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
  Future<Result<Trip?>> getTripContainingPlace(String placeId) async {
    try {
      final tripsResult = await getAllTrips();
      return await tripsResult.when(
        success: (trips) async {
          // Fetch all itineraries in parallel
          final itineraryResults = await Future.wait(
            trips.map((trip) => _itineraryRepository.getItinerary(trip.id)),
          );

          for (int i = 0; i < trips.length; i++) {
            final result = itineraryResults[i];
            final trip = trips[i];

            final isFound = result.when(
              success: (itinerary) =>
                  itinerary != null && _containsPlace(itinerary, placeId),
              failure: (_) => false,
              cancelled: () => false,
            );

            if (isFound) return Result.ok(trip);
          }
          return const Result.ok(null);
        },
        failure: (error) async => Result.error(error),
        cancelled: () async => const Result.cancelled(),
      );
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<bool>> isPlaceInAnyTrip(String placeId) async {
    final result = await getTripContainingPlace(placeId);
    return result.when(
      success: (trip) => Result.ok(trip != null),
      failure: (error) => Result.error(error),
      cancelled: () => const Result.cancelled(),
    );
  }

  // Helpers
  bool _containsPlace(TripItinerary itinerary, String placeId) {
    for (final day in itinerary.days) {
      for (final slot in day.timeSlots) {
        if (slot.places.any((p) => p.id == placeId)) return true;
      }
    }
    return false;
  }
}
