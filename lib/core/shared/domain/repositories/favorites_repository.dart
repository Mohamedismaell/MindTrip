import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';

abstract class FavoritesRepository {
  Future<Result<Set<String>>> getFavoriteIds();
  Future<Result<void>> toggleFavorite({
    required String placeId,
    required bool isFavorite,
  });
  Future<Result<void>> syncPendingFavorites();
  Future<Result<void>> clearAll();
  Future<Result<List<PlaceEntity>>> getFavoritePlaces({
    required Set<String> placeIds,
  });
}
