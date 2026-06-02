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
  Future<List<Trip>> getAllTrips() async {
    final models = await _localDataSource.getAll();
    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<Trip?> getTripById(String id) async {
    final model = await _localDataSource.getById(id);
    return model?.toEntity();
  }

  @override
  Future<void> saveTrip(Trip trip) async {
    final model = TripModel.fromEntity(trip);
    await _localDataSource.save(model);
  }

  @override
  Future<void> updateTrip(Trip trip) async {
    final model = TripModel.fromEntity(trip);
    await _localDataSource.save(model);
  }

  @override
  Future<void> deleteTrip(String id) async {
    await _localDataSource.delete(id);
  }

  @override
  Future<TripItinerary> generateItinerary(Trip trip) async {
    final model = await _itineraryDataSource.generate(trip);
    return model.toEntity();
  }

  @override
  Future<TripItinerary?> getItinerary(String tripId) async {
    final model = await _itineraryDataSource.getByTripId(tripId);
    return model?.toEntity();
  }

  @override
  Future<void> saveItinerary(TripItinerary itinerary) async {
    final model = TripItineraryModel.fromEntity(itinerary);
    await _itineraryDataSource.save(model);
  }

  @override
  Future<Trip?> getTripContainingPlace(String placeId) async {
    final trips = await getAllTrips();
    for (var trip in trips) {
      final itinerary = await getItinerary(trip.id);
      if (itinerary != null && _containsPlace(itinerary, placeId)) {
        return trip;
      }
    }
    return null;
  }

  @override
  Future<bool> isPlaceInAnyTrip(String placeId) async {
    return await getTripContainingPlace(placeId) != null;
  }

  @override
  Future<TripItinerary> addPlace(
    String tripId,
    PlaceEntity place, {
    int? dayNumber,
    DayPeriod? period,
  }) async {
    final currentItinerary = await getItinerary(tripId);
    if (currentItinerary == null) {
      throw Exception('Itinerary not found for trip $tripId');
    }

    if (_containsPlace(currentItinerary, place.id)) return currentItinerary;

    int targetDay = dayNumber ?? _suggestBestSlot(currentItinerary).$1;
    DayPeriod targetPeriod = period ?? _suggestBestSlot(currentItinerary).$2;

    final newDays = currentItinerary.days.map((day) {
      if (day.dayNumber != targetDay) return day;

      final newSlots = day.timeSlots.map((slot) {
        if (slot.period != targetPeriod) return slot;
        return slot.copyWith(places: [...slot.places, place]);
      }).toList();

      return day.copyWith(timeSlots: newSlots, stopCount: day.stopCount + 1);
    }).toList();

    final newItinerary = currentItinerary.copyWith(days: newDays);
    await saveItinerary(newItinerary);
    return newItinerary;
  }

  @override
  Future<TripItinerary> removePlace(String tripId, String placeId) async {
    final currentItinerary = await getItinerary(tripId);
    if (currentItinerary == null) {
      throw Exception('Itinerary not found for trip $tripId');
    }

    final newItinerary = _removePlaceFromItinerary(currentItinerary, placeId);
    await saveItinerary(newItinerary);
    return newItinerary;
  }

  @override
  Future<TripItinerary> movePlace(
    String tripId,
    String placeId,
    int toDayNumber,
    DayPeriod toPeriod,
  ) async {
    final currentItinerary = await getItinerary(tripId);
    if (currentItinerary == null) {
      throw Exception('Itinerary not found for trip $tripId');
    }

    final place = _findPlace(currentItinerary, placeId);
    if (place == null) return currentItinerary;

    final afterRemove = _removePlaceFromItinerary(currentItinerary, placeId);

    final newDays = afterRemove.days.map((day) {
      if (day.dayNumber != toDayNumber) return day;

      final newSlots = day.timeSlots.map((slot) {
        if (slot.period != toPeriod) return slot;
        return slot.copyWith(places: [...slot.places, place]);
      }).toList();

      return day.copyWith(timeSlots: newSlots, stopCount: day.stopCount + 1);
    }).toList();

    final newItinerary = afterRemove.copyWith(days: newDays);
    await saveItinerary(newItinerary);
    return newItinerary;
  }

  @override
  Future<(TripItinerary, TripItinerary)> movePlaceBetweenTrips({
    required String sourceTripId,
    required String targetTripId,
    required String placeId,
    required int toDayNumber,
    required DayPeriod toPeriod,
  }) async {
    final sourceItinerary = await getItinerary(sourceTripId);
    var targetItinerary = await getItinerary(targetTripId);

    if (sourceItinerary == null || targetItinerary == null) {
      throw Exception('Source or target itinerary not found');
    }

    final place = _findPlace(sourceItinerary, placeId);
    if (place == null) return (sourceItinerary, targetItinerary);

    final updatedSource = _removePlaceFromItinerary(sourceItinerary, placeId);

    final newDays = targetItinerary.days.map((day) {
      if (day.dayNumber != toDayNumber) return day;

      final newSlots = day.timeSlots.map((slot) {
        if (slot.period != toPeriod) return slot;
        return slot.copyWith(places: [...slot.places, place]);
      }).toList();

      return day.copyWith(timeSlots: newSlots, stopCount: day.stopCount + 1);
    }).toList();

    var updatedTarget = targetItinerary.copyWith(days: newDays);

    await saveItinerary(updatedSource);
    await saveItinerary(updatedTarget);

    return (updatedSource, updatedTarget);
  }

  // --- Helpers ---
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

  TripItinerary _removePlaceFromItinerary(TripItinerary itinerary, String placeId) {
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
