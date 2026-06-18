import 'package:dio/dio.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/core/shared/models/paginated_response.dart';
import 'package:mindtrip/features/places/data/models/trending_places_request_model.dart';
import 'package:mindtrip/features/places/domain/repositories/place_repository.dart';

class GetPlacesUseCase {
  final PlaceRepository repository;

  GetPlacesUseCase({required this.repository});

  Future<Result<PaginatedResponse<PlaceEntity>>> call({
    required GetPlacesRequestModel request,
    CancelToken? cancelToken,
  }) async {
    return await repository.getPlaces(
      request: request,
      cancelToken: cancelToken,
    );
  }
}
