import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/models/paginated_response.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/features/place_details/domain/repositories/place_details_repository.dart';

class GetNearbyPlacesUseCase {
  final PlaceDetailsRepository repository;

  GetNearbyPlacesUseCase({required this.repository});

  Future<Result<PaginatedResponse<PlaceEntity>>> call(
    String placeId, {
    int page = 1,
    int limit = 10,
    double? lat,
    double? lng,
  }) => repository.getNearbyPlaces(placeId, page: page, limit: limit, lat: lat, lng: lng);
}
