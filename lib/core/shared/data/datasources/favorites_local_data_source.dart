abstract class FavoritesLocalDataSource {
  Future<Set<String>> getFavoriteIds();
  Future<void> addFavoriteIds({required String placeId});
  Future<void> removeFavoriteIds({required String placeId});
  Future<void> clearAll();
  
  // Sync queue
  Future<void> enqueueSyncAction({required String placeId, required String action});
  Future<Map<String, String>> getPendingSyncActions();
  Future<void> removeSyncAction({required String placeId});
}
