import 'package:dio/dio.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/models/paginated_response.dart';
import 'package:mindtrip/features/places/data/models/nearby_places_request_model.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/features/places/domain/repositories/place_repository.dart';

class GetNearbyPlacesUseCase {
  final PlaceRepository _repository;

  GetNearbyPlacesUseCase({required PlaceRepository repository})
    : _repository = repository;

  Future<Result<PaginatedResponse<PlaceEntity>>> call({
    required NearbyPlacesRequestModel request,
    CancelToken? cancelToken,
  }) {
    return _repository.getNearbyPlaces(
      request: request,
      cancelToken: cancelToken,
    );
  }
}
