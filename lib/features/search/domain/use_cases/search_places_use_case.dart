import 'package:dio/dio.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/models/paginated_response.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/features/search/data/models/search_places_request_model.dart';
import 'package:mindtrip/features/search/domain/repositories/search_repository.dart';

class SearchPlacesUseCase {
  final SearchRepository _repository;

  SearchPlacesUseCase(this._repository);

  Future<Result<PaginatedResponse<PlaceEntity>>> call({
    required SearchPlacesRequestModel request,

    CancelToken? cancelToken,
  }) {
    return _repository.searchPlaces(request: request, cancelToken: cancelToken);
  }
}
