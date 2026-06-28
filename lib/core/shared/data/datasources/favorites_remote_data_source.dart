import 'package:mindtrip/core/database/api/api_consumer.dart';
import 'package:mindtrip/core/database/api/end_points.dart';
import 'package:mindtrip/core/shared/data/models/favorite_place_model.dart';
import 'package:mindtrip/core/shared/data/models/favorite_trip_model.dart';

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

  Future<List<FavoriteTripModel>> getFavoriteTripsFromServer() async {
    final response = await _api.get(EndPoints.favoriteTrips);
    return (response as List)
        .map((e) => FavoriteTripModel.fromJson(e))
        .toList();
  }

  Future<FavoriteTripModel> addFavoriteTrip({required String tripId}) async {
    final response = await _api.post(EndPoints.favoriteTrip(tripId));
    return FavoriteTripModel.fromJson(response as Map<String, dynamic>);
  }

  Future<void> deleteFavoriteTrip({required String tripId}) async {
    await _api.delete(EndPoints.favoriteTrip(tripId));
  }
}
