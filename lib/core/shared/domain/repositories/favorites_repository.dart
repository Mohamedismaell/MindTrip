import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';

abstract class FavoritesRepository {
  Future<Result<Set<String>>> getFavoriteIds();
  Future<Result<void>> toggleFavorite({
    required String placeId,
    required bool isFavorite,
  });
  Future<Result<void>> syncPendingFavorites();
  Future<Result<void>> clearAll();
  Future<Result<List<PlaceModel>>> getFavoritePlaces({required Set<String> placeIds});
}
