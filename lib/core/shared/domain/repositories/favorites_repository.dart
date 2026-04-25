import 'package:mindtrip/core/connections/result.dart';

abstract class FavoritesRepository {
  Future<Result<Set<String>>> getFavoriteIds();
  Future<Result<void>> toggleFavorite({
    required String placeId,
    required bool isFavorite,
  });
  Future<Result<void>> syncPendingFavorites();
  Future<Result<void>> clearAll();
}
