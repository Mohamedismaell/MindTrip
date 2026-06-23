import 'package:dio/dio.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/core/shared/models/paginated_response.dart';
import 'package:mindtrip/features/places/data/models/popular_places_request_model.dart';
import 'package:mindtrip/features/places/data/models/recommendation_places_request_model.dart';
import 'package:mindtrip/features/places/data/models/get_places_request_model.dart';
import 'package:mindtrip/features/places/data/models/nearby_places_request_model.dart';

abstract class PlaceRepository {
  Future<Result<PaginatedResponse<PlaceEntity>>> getRecommendedPlaces(
    RecommendationPlacesRequestModel request,
    CancelToken? cancelToken,
  );

  Future<Result<PaginatedResponse<PlaceEntity>>> getPopularPlaces(
    PopularPlacesRequestModel request,
    CancelToken? cancelToken,
  );

  Future<Result<PaginatedResponse<PlaceEntity>>> getPlaces({
    required GetPlacesRequestModel request,
    CancelToken? cancelToken,
  });

  Future<Result<PaginatedResponse<PlaceEntity>>> getNearbyPlaces({
    required NearbyPlacesRequestModel request,
    CancelToken? cancelToken,
  });
}
