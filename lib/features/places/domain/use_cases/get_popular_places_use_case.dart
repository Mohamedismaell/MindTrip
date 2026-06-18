import 'package:dio/dio.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/core/shared/models/paginated_response.dart';
import 'package:mindtrip/features/places/data/models/popular_request_model.dart';
import 'package:mindtrip/features/places/domain/repositories/place_repository.dart';

class GetPopularPlacesUseCase {
  final PlaceRepository repository;

  GetPopularPlacesUseCase({required this.repository});

  Future<Result<PaginatedResponse<PlaceEntity>>> call({
    required PopularRequestModel request,
    CancelToken? cancelToken,
  }) async {
    return await repository.getPopularPlaces(request, cancelToken);
  }
}
