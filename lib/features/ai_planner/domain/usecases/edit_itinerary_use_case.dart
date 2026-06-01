import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/time_slot.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip_itinerary.dart';

class EditItineraryUseCase {
  /// Adds [place] to [dayNumber] at the given [period].
  ///
  /// If the place already exists anywhere in the itinerary (same ID),
  /// the itinerary is returned unchanged to prevent duplicates.
  TripItinerary addPlace(
    TripItinerary itinerary, {
    required int dayNumber,
    required DayPeriod period,
    required PlaceEntity place,
  }) {
    // Duplicate guard
    if (_containsPlace(itinerary, place.id)) return itinerary;

    final newDays = itinerary.days.map((day) {
      if (day.dayNumber != dayNumber) return day;

      final newSlots = day.timeSlots.map((slot) {
        if (slot.period != period) return slot;
        return slot.copyWith(places: [...slot.places, place]);
      }).toList();

      return day.copyWith(timeSlots: newSlots, stopCount: day.stopCount + 1);
    }).toList();

    return itinerary.copyWith(days: newDays);
  }

  // ────────────────────────────────────────────────────────────
  //  REMOVE
  // ────────────────────────────────────────────────────────────

  /// Removes the place with [placeId] from wherever it sits.
  ///
  /// Returns the itinerary unchanged if [placeId] is not found.
  TripItinerary removePlace(
    TripItinerary itinerary, {
    required String placeId,
  }) {
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

  // ────────────────────────────────────────────────────────────
  //  MOVE (within same trip)
  // ────────────────────────────────────────────────────────────

  /// Moves the place with [placeId] to [toDayNumber] / [toPeriod].
  ///
  /// This is a combined remove + add: the place is removed from its
  /// current position and appended to the target slot.
  TripItinerary movePlace(
    TripItinerary itinerary, {
    required String placeId,
    required int toDayNumber,
    required DayPeriod toPeriod,
  }) {
    // Find the place first
    final place = _findPlace(itinerary, placeId);
    if (place == null) return itinerary;

    // Remove from current position
    final afterRemove = removePlace(itinerary, placeId: placeId);

    // Add to target position
    return addPlace(
      afterRemove,
      dayNumber: toDayNumber,
      period: toPeriod,
      place: place,
    );
  }

  // ────────────────────────────────────────────────────────────
  //  REORDER (within a single slot)
  // ────────────────────────────────────────────────────────────

  /// Reorders a place within a single time slot (drag & drop).
  TripItinerary reorderPlace(
    TripItinerary itinerary, {
    required int dayNumber,
    required DayPeriod period,
    required int oldIndex,
    required int newIndex,
  }) {
    final newDays = itinerary.days.map((day) {
      if (day.dayNumber != dayNumber) return day;

      final newSlots = day.timeSlots.map((slot) {
        if (slot.period != period) return slot;

        final places = List<PlaceEntity>.from(slot.places);
        if (oldIndex < 0 ||
            oldIndex >= places.length ||
            newIndex < 0 ||
            newIndex >= places.length) {
          return slot;
        }

        final item = places.removeAt(oldIndex);
        places.insert(newIndex, item);
        return slot.copyWith(places: places);
      }).toList();

      return day.copyWith(timeSlots: newSlots);
    }).toList();

    return itinerary.copyWith(days: newDays);
  }

  // ────────────────────────────────────────────────────────────
  //  MOVE BETWEEN TRIPS
  // ────────────────────────────────────────────────────────────

  /// Moves a place from [source] itinerary to [target] itinerary.
  ///
  /// Returns both updated itineraries as a record.
  (TripItinerary source, TripItinerary target) movePlaceBetweenTrips({
    required TripItinerary source,
    required TripItinerary target,
    required String placeId,
    required int toDayNumber,
    required DayPeriod toPeriod,
  }) {
    final place = _findPlace(source, placeId);
    if (place == null) return (source, target);

    final updatedSource = removePlace(source, placeId: placeId);
    final updatedTarget = addPlace(
      target,
      dayNumber: toDayNumber,
      period: toPeriod,
      place: place,
    );

    return (updatedSource, updatedTarget);
  }

  // ────────────────────────────────────────────────────────────
  //  SUGGEST BEST SLOT ("Let AI Decide")
  // ────────────────────────────────────────────────────────────

  /// Returns the day and period with the fewest places.
  ///
  /// Ties are broken by picking the earliest day, then earliest period
  /// (morning → afternoon → evening).
  (int dayNumber, DayPeriod period) suggestBestSlot(TripItinerary itinerary) {
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

  // ────────────────────────────────────────────────────────────
  //  PRIVATE HELPERS
  // ────────────────────────────────────────────────────────────

  /// Checks if a place with [placeId] exists anywhere in the itinerary.
  bool _containsPlace(TripItinerary itinerary, String placeId) {
    for (final day in itinerary.days) {
      for (final slot in day.timeSlots) {
        if (slot.places.any((p) => p.id == placeId)) return true;
      }
    }
    return false;
  }

  /// Finds and returns the [PlaceEntity] with [placeId], or null.
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
}
