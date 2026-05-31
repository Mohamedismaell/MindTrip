import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';

abstract class PlaceDetailsRepository {
  Future<Result<PlaceModel>> getPlaceDetails(String placeId);

  Future<Result<List<PlaceModel>>> getNearbyPlaces(
    String placeId, {
    double? lat,
    double? lng,
  });
}
