import 'package:dio/dio.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/core/shared/models/paginated_response.dart';
import 'package:mindtrip/features/places/data/models/trending_places_request.dart';
import 'package:mindtrip/features/places/domain/repositories/place_repository.dart';

class GetTrendingPlacesUseCase {
  final PlaceRepository repository;

  GetTrendingPlacesUseCase({required this.repository});

  Future<Result<PaginatedResponse<PlaceEntity>>> call({
    required TrendingPlacesRequest request,
    CancelToken? cancelToken,
  }) async {
    return await repository.getTrindingPlaces(
      request: request,
      cancelToken: cancelToken,
    );
  }
}
