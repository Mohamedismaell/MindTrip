import 'package:mindtrip/core/database/api/api_consumer.dart';
import 'package:mindtrip/core/database/api/end_points.dart';
import 'package:mindtrip/core/shared/models/paginated_response.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/features/places/data/models/recommendation_request_model.dart';

abstract class PlaceRemoteDataSource {
  Future<PaginatedResponse<PlaceModel>> getRecommendedPlaces(
    RecommendationRequestModel request,
  );

  Future<PaginatedResponse<PlaceModel>> getPopularPlaces({
    Map<String, dynamic>? filters,
    int page = 1,
    int limit = 10,
  });

  Future<PaginatedResponse<PlaceModel>> searchPlaces({
    String? query,
    Map<String, dynamic>? filters,
    int page = 1,
    int limit = 10,
  });

  Future<PaginatedResponse<PlaceModel>> getPlaces({
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

class PlaceRemoteDataSourceImpl implements PlaceRemoteDataSource {
  final ApiConsumer _api;

  PlaceRemoteDataSourceImpl({required ApiConsumer api}) : _api = api;

  @override
  Future<PaginatedResponse<PlaceModel>> getRecommendedPlaces(
    RecommendationRequestModel request,
  ) async {
    final response = await _api.post(
      EndPoints.getRecommendedPlaces,
      data: request.toJson(),
    );

    return PaginatedResponse<PlaceModel>.fromJson(
      response,
      (json) => PlaceModel.fromJson(json),
    );
  }

  @override
  Future<PaginatedResponse<PlaceModel>> getPopularPlaces({
    Map<String, dynamic>? filters,
    int page = 1,
    int limit = 10,
  }) async {
    final requestBody = {
      if (filters != null && filters.isNotEmpty) 'filters': filters,
      'page': page,
      'limit': limit,
    };

    final response = await _api.post(
      EndPoints.getPopularPlaces,
      data: requestBody,
    );

    return PaginatedResponse<PlaceModel>.fromJson(
      response,
      (json) => PlaceModel.fromJson(json),
    );
  }

  @override
  Future<PaginatedResponse<PlaceModel>> searchPlaces({
    String? query,
    Map<String, dynamic>? filters,
    int page = 1,
    int limit = 10,
  }) async {
    final requestBody = {
      if (query != null && query.isNotEmpty) 'query': query,
      if (filters != null && filters.isNotEmpty) 'filters': filters,
      'page': page,
      'limit': limit,
    };

    final response = await _api.post(EndPoints.searchPlaces, data: requestBody);

    return PaginatedResponse<PlaceModel>.fromJson(
      response,
      (json) => PlaceModel.fromJson(json),
    );
  }

  @override
  Future<PaginatedResponse<PlaceModel>> getPlaces({
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
  }) async {
    final requestBody = {
      'city': ?city,
      'category': ?category,
      'interests': ?interests,
      'min_rating': ?minRating,
      'max_rating': ?maxRating,
      'min_price': ?minPrice,
      'max_price': ?maxPrice,
      'hidden_gem': ?hiddenGem,
      'sort_by': ?sortBy,
      'order': ?order,
      'page': page,
      'limit': limit,
    };

    final response = await _api.post(EndPoints.getPlaces, data: requestBody);

    return PaginatedResponse<PlaceModel>.fromJson(
      response,
      (json) => PlaceModel.fromJson(json),
    );
  }
}
