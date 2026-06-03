import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/database/api/api_error_mapper.dart';
import 'package:mindtrip/core/errors/failure/failure.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/features/ai_planner/data/datasources/trip_local_datasource.dart';
import 'package:mindtrip/features/ai_planner/data/models/trip_model.dart';
import 'package:mindtrip/features/ai_planner/data/datasources/mock_itinerary_datasource.dart';
import 'package:mindtrip/features/ai_planner/data/models/trip_itinerary_model.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/time_slot.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip_itinerary.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/trip_repository.dart';

class TripRepositoryImpl implements TripRepository {
  final TripLocalDataSource _localDataSource;
  final ItineraryDataSource _itineraryDataSource;

  const TripRepositoryImpl(this._localDataSource, this._itineraryDataSource);

  @override
  Future<Result<List<Trip>>> getAllTrips() async {
    try {
      final models = await _localDataSource.getAll();
      return Result.ok(models.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Result.error(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<Trip?>> getTripById(String id) async {
    try {
      final model = await _localDataSource.getById(id);
      return Result.ok(model?.toEntity());
    } catch (e) {
      return Result.error(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> saveTrip(Trip trip) async {
    try {
      final model = TripModel.fromEntity(trip);
      await _localDataSource.save(model);
      return const Result.ok(null);
    } catch (e) {
      return Result.error(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> updateTrip(Trip trip) async {
    try {
      final model = TripModel.fromEntity(trip);
      await _localDataSource.save(model);
      return const Result.ok(null);
    } catch (e) {
      return Result.error(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> deleteTrip(String id) async {
    try {
      await _localDataSource.delete(id);
      return const Result.ok(null);
    } catch (e) {
      return Result.error(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<TripItinerary>> generateItinerary(Trip trip) async {
    try {
      final model = await _itineraryDataSource.generate(trip);
      return Result.ok(model.toEntity());
    } catch (e) {
      return Result.error(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<TripItinerary?>> getItinerary(String tripId) async {
    try {
      final model = await _itineraryDataSource.getByTripId(tripId);
      return Result.ok(model?.toEntity());
    } catch (e) {
      return Result.error(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> saveItinerary(TripItinerary itinerary) async {
    try {
      final model = TripItineraryModel.fromEntity(itinerary);
      await _itineraryDataSource.save(model);
      return const Result.ok(null);
    } catch (e) {
      return Result.error(ServerFailure(e.toString()));
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
            trips.map((trip) => getItinerary(trip.id)),
          );

          for (int i = 0; i < trips.length; i++) {
            final result = itineraryResults[i];
            final trip = trips[i];

            final isFound = result.when(
              success: (itinerary) =>
                  itinerary != null && _containsPlace(itinerary, placeId),
              failure: (_) => false,
            );

            if (isFound) return Result.ok(trip);
          }
          return const Result.ok(null);
        },
        failure: (error) async => Result.error(error),
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
    );
  }

  @override
  Future<Result<TripItinerary>> addPlace(
    String tripId,
    PlaceEntity place, {
    int? dayNumber,
    DayPeriod? period,
  }) async {
    try {
      final currentItineraryResult = await getItinerary(tripId);

      return await currentItineraryResult.when(
        success: (currentItinerary) async {
          if (currentItinerary == null) {
            return Result.error(
              ServerFailure('Itinerary not found for trip $tripId'),
            );
          }

          if (_containsPlace(currentItinerary, place.id)) {
            return Result.ok(currentItinerary);
          }

          int targetDay = dayNumber ?? _suggestBestSlot(currentItinerary).$1;
          DayPeriod targetPeriod =
              period ?? _suggestBestSlot(currentItinerary).$2;

          final newDays = currentItinerary.days.map((day) {
            if (day.dayNumber != targetDay) return day;

            final newSlots = day.timeSlots.map((slot) {
              if (slot.period != targetPeriod) return slot;
              return slot.copyWith(places: [...slot.places, place]);
            }).toList();

            return day.copyWith(
              timeSlots: newSlots,
              stopCount: day.stopCount + 1,
            );
          }).toList();

          final newItinerary = currentItinerary.copyWith(days: newDays);
          await saveItinerary(newItinerary);
          return Result.ok(newItinerary);
        },
        failure: (error) async => Result.error(error),
      );
    } catch (e) {
      return Result.error(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<TripItinerary>> removePlace(
    String tripId,
    String placeId,
  ) async {
    try {
      final currentItineraryResult = await getItinerary(tripId);

      return await currentItineraryResult.when(
        success: (currentItinerary) async {
          if (currentItinerary == null) {
            return Result.error(
              ServerFailure('Itinerary not found for trip $tripId'),
            );
          }

          final newItinerary = _removePlaceFromItinerary(
            currentItinerary,
            placeId,
          );
          await saveItinerary(newItinerary);
          return Result.ok(newItinerary);
        },
        failure: (error) async => Result.error(error),
      );
    } catch (e) {
      return Result.error(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<TripItinerary>> movePlace(
    String tripId,
    String placeId,
    int toDayNumber,
    DayPeriod toPeriod,
  ) async {
    try {
      final currentItineraryResult = await getItinerary(tripId);

      return await currentItineraryResult.when(
        success: (currentItinerary) async {
          if (currentItinerary == null) {
            return Result.error(
              ServerFailure('Itinerary not found for trip $tripId'),
            );
          }

          final place = _findPlace(currentItinerary, placeId);
          if (place == null) return Result.ok(currentItinerary);

          final afterRemove = _removePlaceFromItinerary(
            currentItinerary,
            placeId,
          );

          final newDays = afterRemove.days.map((day) {
            if (day.dayNumber != toDayNumber) return day;

            final newSlots = day.timeSlots.map((slot) {
              if (slot.period != toPeriod) return slot;
              return slot.copyWith(places: [...slot.places, place]);
            }).toList();

            return day.copyWith(
              timeSlots: newSlots,
              stopCount: day.stopCount + 1,
            );
          }).toList();

          final newItinerary = afterRemove.copyWith(days: newDays);
          await saveItinerary(newItinerary);
          return Result.ok(newItinerary);
        },
        failure: (error) async => Result.error(error),
      );
    } catch (e) {
      return Result.error(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<(TripItinerary, TripItinerary)>> movePlaceBetweenTrips({
    required String sourceTripId,
    required String targetTripId,
    required String placeId,
    required int toDayNumber,
    required DayPeriod toPeriod,
  }) async {
    try {
      final sourceResult = await getItinerary(sourceTripId);
      final targetResult = await getItinerary(targetTripId);

      return await sourceResult.when(
        success: (sourceItinerary) async {
          return await targetResult.when(
            success: (targetItinerary) async {
              if (sourceItinerary == null || targetItinerary == null) {
                return Result.error(
                  ServerFailure('Source or target itinerary not found'),
                );
              }

              final place = _findPlace(sourceItinerary, placeId);
              if (place == null) {
                return Result.ok((sourceItinerary, targetItinerary));
              }

              final updatedSource = _removePlaceFromItinerary(
                sourceItinerary,
                placeId,
              );

              final newDays = targetItinerary.days.map((day) {
                if (day.dayNumber != toDayNumber) return day;

                final newSlots = day.timeSlots.map((slot) {
                  if (slot.period != toPeriod) return slot;
                  return slot.copyWith(places: [...slot.places, place]);
                }).toList();

                return day.copyWith(
                  timeSlots: newSlots,
                  stopCount: day.stopCount + 1,
                );
              }).toList();

              var updatedTarget = targetItinerary.copyWith(days: newDays);

              await saveItinerary(updatedSource);
              await saveItinerary(updatedTarget);

              return Result.ok((updatedSource, updatedTarget));
            },
            failure: (error) async => Result.error(error),
          );
        },
        failure: (error) async => Result.error(error),
      );
    } catch (e) {
      return Result.error(ServerFailure(e.toString()));
    }
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

  PlaceEntity? _findPlace(TripItinerary itinerary, String placeId) {
    for (final day in itinerary.days) {
      for (final slot in day.timeSlots) {
        for (final place in slot.places) {
          if (place.id == placeId) return place;
        }
      }
    }
    return null;
  }

  TripItinerary _removePlaceFromItinerary(
    TripItinerary itinerary,
    String placeId,
  ) {
    final newDays = itinerary.days.map((day) {
      bool removed = false;

      final newSlots = day.timeSlots.map((slot) {
        final filtered = slot.places.where((p) => p.id != placeId).toList();
        if (filtered.length != slot.places.length) removed = true;
        return slot.copyWith(places: filtered);
      }).toList();

      return removed
          ? day.copyWith(
              timeSlots: newSlots,
              stopCount: (day.stopCount - 1).clamp(0, 999),
            )
          : day;
    }).toList();

    return itinerary.copyWith(days: newDays);
  }

  (int, DayPeriod) _suggestBestSlot(TripItinerary itinerary) {
    if (itinerary.days.isEmpty) return (1, DayPeriod.morning);

    int bestDay = itinerary.days.first.dayNumber;
    DayPeriod bestPeriod = DayPeriod.morning;
    int minCount = 999;

    for (final day in itinerary.days) {
      for (final slot in day.timeSlots) {
        if (slot.places.length < minCount) {
          minCount = slot.places.length;
          bestDay = day.dayNumber;
          bestPeriod = slot.period;
        }
      }
    }

    return (bestDay, bestPeriod);
  }
}
