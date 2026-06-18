import 'package:dio/dio.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/database/api/api_error_mapper.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/core/shared/models/paginated_response.dart';
import 'package:mindtrip/features/places/data/datasources/place_remote_data_source.dart';
import 'package:mindtrip/core/shared/data/mapper/place_mapper.dart';
import 'package:mindtrip/features/places/data/models/popular_places_request_model.dart';
import 'package:mindtrip/features/places/data/models/recommendation_places_request_model.dart';
import 'package:mindtrip/features/places/data/models/trending_places_request.dart';
import 'package:mindtrip/features/places/domain/repositories/place_repository.dart';

class PlaceRepositoryImpl implements PlaceRepository {
  final PlaceRemoteDataSource remoteDataSource;

  PlaceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<PaginatedResponse<PlaceEntity>>> getRecommendedPlaces(
    RecommendationPlacesRequestModel request,
    CancelToken? cancelToken,
  ) async {
    try {
      final response = await remoteDataSource.getRecommendedPlaces(
        request,
        cancelToken,
      );
      return Result.ok(response.map((e) => e.toEntity()));
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<PaginatedResponse<PlaceEntity>>> getPopularPlaces(
    PopularPlacesRequestModel request,
    CancelToken? cancelToken,
  ) async {
    try {
      final response = await remoteDataSource.getPopularPlaces(
        request,
        cancelToken,
      );
      return Result.ok(response.map((e) => e.toEntity()));
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<PaginatedResponse<PlaceEntity>>> searchPlaces({
    String? query,
    Map<String, dynamic>? filters,
    int page = 1,
    int limit = 10,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await remoteDataSource.searchPlaces(
        query: query,
        filters: filters,
        page: page,
        limit: limit,
        cancelToken: cancelToken,
      );
      return Result.ok(response.map((e) => e.toEntity()));
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<PaginatedResponse<PlaceEntity>>> getTrindingPlaces({
    required TrendingPlacesRequest request,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await remoteDataSource.getTrindingPlaces(
        request: request,
        cancelToken: cancelToken,
      );
      return Result.ok(response.map((e) => e.toEntity()));
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }
}
