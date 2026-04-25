import 'package:mindtrip/core/database/api/api_consumer.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';

class FavoritesRemoteDataSource {
  final ApiConsumer _api;

  FavoritesRemoteDataSource({required ApiConsumer api}) : _api = api;

  // TODO: Replace with actual endpoint
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

  Future<List<PlaceModel>> getFavoritePlaces({
    required Set<String> placeIds,
  }) async {
    // final response = await _api.post(EndPoints.placesBatch, body: { 'ids': placeIds.toList() });
    // return (response as List).map((e) => PlaceModel.fromJson(e)).toList();
    return []; // Placeholder
  }
}
