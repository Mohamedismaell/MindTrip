import 'package:mindtrip/core/database/api/api_consumer.dart';

class FavoritesRemoteDataSource {
  final ApiConsumer _api;

  FavoritesRemoteDataSource({required ApiConsumer api}) : _api = api;

  //! there is no End point for now
  Future<Set<String>> getFavoriteIds() async {
    // final response = await _api.get(EndPoints.favorites);
    // return response['placeIds'];
    return {};
  }

  Future<void> deleteFavoriteIds({required String placeId}) async {
    // final response = await _api.get(EndPoints.favorites);
    // return response['placeIds'];
  }
  Future<void> addFavoriteId({required String placeId}) async {
    // final response = await _api.get(EndPoints.favorites);
    // return response['placeIds'];
  }
  Future<void> clearAll() async {
    // final response = await _api.get(EndPoints.favorites);
    // return response['placeIds'];
  }
}
