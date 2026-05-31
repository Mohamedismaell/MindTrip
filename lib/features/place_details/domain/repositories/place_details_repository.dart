import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';

abstract class PlaceDetailsRepository {
  Future<Result<PlaceEntity>> getPlaceDetails(String placeId);

  Future<Result<List<PlaceEntity>>> getNearbyPlaces(
    String placeId, {
    double? lat,
    double? lng,
  });
}
