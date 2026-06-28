import 'package:hive_ce_flutter/adapters.dart';
import 'package:mindtrip/core/shared/data/models/favorite_trip_model.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';

abstract class FavoritesLocalDataSource {
  Future<Set<String>> getFavoriteIds();
  Future<void> addFavoritePlace({required PlaceModel place});
  Future<void> removeFavoritePlace({required String placeId});
  Future<void> replaceAllPlaces(List<PlaceModel> places);
  Future<List<PlaceModel>> getAllFavoritePlaces();
  Future<void> clearAll();

  Future<Set<String>> getFavoriteTripIds();
  Future<void> addFavoriteTrip({required FavoriteTripModel trip});
  Future<void> removeFavoriteTrip({required String tripId});
  Future<void> replaceAllTrips(List<FavoriteTripModel> trips);
  Future<List<FavoriteTripModel>> getAllFavoriteTrips();

  // Sync queue
  Future<void> enqueueSyncAction({
    required String placeId,
    required String action,
  });
  Future<Map<String, String>> getPendingSyncActions();
  Future<void> removeSyncAction({required String placeId});

  Future<void> enqueueTripSyncAction({
    required String tripId,
    required String action,
  });
  Future<Map<String, String>> getPendingTripSyncActions();
  Future<void> removeTripSyncAction({required String tripId});
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  final Box<PlaceModel> box;
  final Box<String> syncQueueBox;
  final Box<FavoriteTripModel> tripBox;
  final Box<String> tripSyncQueueBox;

  FavoritesLocalDataSourceImpl({
    required this.box,
    required this.syncQueueBox,
    required this.tripBox,
    required this.tripSyncQueueBox,
  });

  @override
  Future<Set<String>> getFavoriteIds() async {
    return box.keys.map((e) => e.toString()).toSet();
  }

  @override
  Future<void> clearAll() async {
    await box.clear();
    await syncQueueBox.clear();
    await tripBox.clear();
    await tripSyncQueueBox.clear();
  }

  @override
  Future<void> addFavoritePlace({required PlaceModel place}) {
    return box.put(place.id, place);
  }

  @override
  Future<void> removeFavoritePlace({required String placeId}) async {
    return await box.delete(placeId);
  }

  @override
  Future<void> replaceAllPlaces(List<PlaceModel> places) async {
    await box.clear();
    final entries = <String, PlaceModel>{};
    for (var p in places) {
      entries[p.id] = p;
    }
    await box.putAll(entries);
  }

  @override
  Future<List<PlaceModel>> getAllFavoritePlaces() async {
    return box.values.toList();
  }

  @override
  Future<Set<String>> getFavoriteTripIds() async {
    return tripBox.keys.map((e) => e.toString()).toSet();
  }

  @override
  Future<void> addFavoriteTrip({required FavoriteTripModel trip}) {
    return tripBox.put(trip.tripId, trip);
  }

  @override
  Future<void> removeFavoriteTrip({required String tripId}) async {
    return await tripBox.delete(tripId);
  }

  @override
  Future<void> replaceAllTrips(List<FavoriteTripModel> trips) async {
    await tripBox.clear();
    final entries = <String, FavoriteTripModel>{};
    for (var trip in trips) {
      entries[trip.tripId] = trip;
    }
    await tripBox.putAll(entries);
  }

  @override
  Future<List<FavoriteTripModel>> getAllFavoriteTrips() async {
    return tripBox.values.toList();
  }

  @override
  Future<void> enqueueSyncAction({
    required String placeId,
    required String action,
  }) async {
    await syncQueueBox.put(placeId, action);
  }

  @override
  Future<Map<String, String>> getPendingSyncActions() async {
    final actions = <String, String>{};
    for (final key in syncQueueBox.keys) {
      actions[key.toString()] = syncQueueBox.get(key)!;
    }
    return actions;
  }

  @override
  Future<void> removeSyncAction({required String placeId}) async {
    await syncQueueBox.delete(placeId);
  }

  @override
  Future<void> enqueueTripSyncAction({
    required String tripId,
    required String action,
  }) async {
    await tripSyncQueueBox.put(tripId, action);
  }

  @override
  Future<Map<String, String>> getPendingTripSyncActions() async {
    final actions = <String, String>{};
    for (final key in tripSyncQueueBox.keys) {
      actions[key.toString()] = tripSyncQueueBox.get(key)!;
    }
    return actions;
  }

  @override
  Future<void> removeTripSyncAction({required String tripId}) async {
    await tripSyncQueueBox.delete(tripId);
  }
}
