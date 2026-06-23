import 'package:mindtrip/core/database/api/api_consumer.dart';
import 'package:mindtrip/core/database/api/end_points.dart';
import 'package:mindtrip/core/shared/data/models/favorite_place_model.dart';

class FavoritesRemoteDataSource {
  final ApiConsumer _api;

  FavoritesRemoteDataSource({required ApiConsumer api}) : _api = api;

  Future<List<FavoritePlaceModel>> getFavoritePlacesFromServer() async {
    final response = await _api.get(EndPoints.favoritePlaces);
    return (response as List)
        .map((e) => FavoritePlaceModel.fromJson(e))
        .toList();
  }

  Future<void> deleteFavoriteIds({required String placeId}) async {
    await _api.delete(EndPoints.deleteFavoritePlace(placeId));
  }

  Future<void> addFavoriteId({required String placeId}) async {
    await _api.post(EndPoints.favoritePlaces, data: {'placeId': placeId});
  }

}
