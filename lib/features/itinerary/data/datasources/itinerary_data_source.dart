import 'dart:convert';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:mindtrip/features/itinerary/data/models/trip_itinerary_model.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';

abstract class ItineraryDataSource {
  Future<TripItineraryModel> generate(Trip trip);
  Future<TripItineraryModel?> getByTripId(String tripId);
  Future<void> save(TripItineraryModel itinerary);
}

class MockItineraryDataSource implements ItineraryDataSource {
  final Box<String> _box;

  MockItineraryDataSource(this._box);

  @override
  Future<TripItineraryModel> generate(Trip trip) async {
    await Future.delayed(const Duration(seconds: 2));
    // Returning an empty itinerary for now as we transition away from mocks
    return TripItineraryModel(
      tripId: trip.id,
      estimatedTotalCost: 0,
      days: [],
    );
  }

  @override
  Future<TripItineraryModel?> getByTripId(String tripId) async {
    final json = _box.get(tripId);
    if (json == null) return null;
    try {
      return TripItineraryModel.fromJson(
        jsonDecode(json) as Map<String, dynamic>,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> save(TripItineraryModel itinerary) async {
    await _box.put(itinerary.tripId, jsonEncode(itinerary.toJson()));
  }
}
