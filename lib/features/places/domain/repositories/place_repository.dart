import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/core/shared/models/paginated_response.dart';
import 'package:mindtrip/features/places/data/models/recommendation_request_model.dart';

abstract class PlaceRepository {
  Future<Result<PaginatedResponse<PlaceEntity>>> getRecommendedPlaces(
      RecommendationRequestModel request);

  Future<Result<PaginatedResponse<PlaceEntity>>> getPopularPlaces({
    Map<String, dynamic>? filters,
    int page = 1,
    int limit = 10,
  });

  Future<Result<PaginatedResponse<PlaceEntity>>> searchPlaces({
    String? query,
    Map<String, dynamic>? filters,
    int page = 1,
    int limit = 10,
  });

  Future<Result<PaginatedResponse<PlaceEntity>>> getPlaces({
    Map<String, dynamic>? filters,
    List<String>? city,
    List<String>? category,
    List<String>? interests,
    double? minRating,
    double? maxRating,
    double? minPrice,
    double? maxPrice,
    bool? hiddenGem,
    String? sortBy,
    String? order,
    int page = 1,
    int limit = 10,
  });
}
