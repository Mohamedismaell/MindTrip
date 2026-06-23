import 'package:hive_ce_flutter/adapters.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';

abstract class FavoritesLocalDataSource {
  Future<Set<String>> getFavoriteIds();
  Future<void> addFavoritePlace({required PlaceModel place});
  Future<void> removeFavoritePlace({required String placeId});
  Future<void> replaceAllPlaces(List<PlaceModel> places);
  Future<List<PlaceModel>> getAllFavoritePlaces();
  Future<void> clearAll();

  // Sync queue
  Future<void> enqueueSyncAction({
    required String placeId,
    required String action,
  });
  Future<Map<String, String>> getPendingSyncActions();
  Future<void> removeSyncAction({required String placeId});
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  final Box<PlaceModel> box;
  final Box<String> syncQueueBox;

  FavoritesLocalDataSourceImpl({required this.box, required this.syncQueueBox});

  @override
  Future<Set<String>> getFavoriteIds() async {
    return box.keys.map((e) => e.toString()).toSet();
  }

  @override
  Future<void> clearAll() async {
    await box.clear();
    await syncQueueBox.clear();
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
}
