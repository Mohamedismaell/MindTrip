import 'package:dio/dio.dart';
import 'package:mindtrip/core/database/api/api_consumer.dart';
import 'package:mindtrip/core/database/api/end_points.dart';
import 'package:mindtrip/core/shared/models/paginated_response.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/features/places/data/models/popular_places_request_model.dart';
import 'package:mindtrip/features/places/data/models/recommendation_places_request_model.dart';
import 'package:mindtrip/features/places/data/models/trending_places_request.dart';

abstract class PlaceRemoteDataSource {
  Future<PaginatedResponse<PlaceModel>> getRecommendedPlaces(
    RecommendationPlacesRequestModel request,
    CancelToken? cancelToken,
  );

  Future<PaginatedResponse<PlaceModel>> getPopularPlaces(
    PopularPlacesRequestModel request,
    CancelToken? cancelToken,
  );

  Future<PaginatedResponse<PlaceModel>> searchPlaces({
    String? query,
    Map<String, dynamic>? filters,
    int page = 1,
    int limit = 10,
    CancelToken? cancelToken,
  });

  Future<PaginatedResponse<PlaceModel>> getTrindingPlaces({
    required TrendingPlacesRequest request,
    CancelToken? cancelToken,
  });
}

class PlaceRemoteDataSourceImpl implements PlaceRemoteDataSource {
  final ApiConsumer _api;

  PlaceRemoteDataSourceImpl({required ApiConsumer api}) : _api = api;

  @override
  Future<PaginatedResponse<PlaceModel>> getRecommendedPlaces(
    RecommendationPlacesRequestModel request,
    CancelToken? cancelToken,
  ) async {
    final response = await _api.post(
      EndPoints.getRecommendedPlaces,
      data: request.toJson(),
      cancelToken: cancelToken,
    );

    return PaginatedResponse<PlaceModel>.fromJson(
      response,
      (json) => PlaceModel.fromJson(json),
    );
  }

  @override
  Future<PaginatedResponse<PlaceModel>> getPopularPlaces(
    PopularPlacesRequestModel request,
    CancelToken? cancelToken,
  ) async {
    final response = await _api.post(
      EndPoints.getPopularPlaces,
      data: request.toJson(),
      cancelToken: cancelToken,
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

    CancelToken? cancelToken,
  }) async {
    final requestBody = {
      if (query != null && query.isNotEmpty) 'query': query,
      if (filters != null && filters.isNotEmpty) 'filters': filters,
      'page': page,
      'limit': limit,
    };

    final response = await _api.post(
      EndPoints.searchPlaces,
      data: requestBody,

      cancelToken: cancelToken,
    );

    return PaginatedResponse<PlaceModel>.fromJson(
      response,
      (json) => PlaceModel.fromJson(json),
    );
  }

  @override
  Future<PaginatedResponse<PlaceModel>> getTrindingPlaces({
    required TrendingPlacesRequest request,
    CancelToken? cancelToken,
  }) async {
    final requestBody = request.toJson();

    final response = await _api.post(
      EndPoints.getPlaces,
      data: requestBody,
      cancelToken: cancelToken,
    );

    return PaginatedResponse<PlaceModel>.fromJson(
      response,
      (json) => PlaceModel.fromJson(json),
    );
  }
}
