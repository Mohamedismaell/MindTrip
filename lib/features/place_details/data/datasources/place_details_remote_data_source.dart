import 'package:mindtrip/core/shared/data/models/place_model.dart';

class PlaceDetailsRemoteDataSource {
  PlaceDetailsRemoteDataSource();

  Future<PlaceModel> getPlaceDetails(String placeId) async {
    // Returning a dummy PlaceModel until real API is implemented
    return PlaceModel(
      placeId: placeId,
      name: 'Loading...',
      lat: 0.0,
      lng: 0.0,
    );
  }

  Future<List<PlaceModel>> getNearbyPlaces(
    String placeId, {
    double? lat,
    double? lng,
  }) async {
    return [];
  }
}
