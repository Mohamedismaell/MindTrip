import 'package:hive_ce_flutter/adapters.dart';
import 'package:mindtrip/core/shared/data/datasources/favorites_local_data_source.dart';

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  final Box<String> box;
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
  Future<void> addFavoriteIds({required String placeId}) {
    return box.put(placeId, placeId);
  }

  @override
  Future<void> removeFavoriteIds({required String placeId}) async {
    return await box.delete(placeId);
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
