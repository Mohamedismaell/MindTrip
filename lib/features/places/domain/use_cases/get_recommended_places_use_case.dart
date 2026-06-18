import 'package:dio/dio.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/core/shared/models/paginated_response.dart';
import 'package:mindtrip/features/places/data/models/recommendation_request_model.dart';
import 'package:mindtrip/features/places/domain/repositories/place_repository.dart';

class GetRecommendedPlacesUseCase {
  final PlaceRepository repository;

  GetRecommendedPlacesUseCase({required this.repository});

  Future<Result<PaginatedResponse<PlaceEntity>>> call({
    required RecommendationRequestModel request,
    CancelToken? cancelToken,
  }) async {
    return await repository.getRecommendedPlaces(request, cancelToken);
  }
}
