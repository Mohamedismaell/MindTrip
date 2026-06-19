import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/models/paginated_response.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';

abstract class PlaceDetailsRepository {
  Future<Result<PlaceEntity>> getPlaceDetails(String placeId);

  Future<Result<PaginatedResponse<PlaceEntity>>> getNearbyPlaces(
    String placeId, {
    int page = 1,
    int limit = 10,
    double? lat,
    double? lng,
  });
}
