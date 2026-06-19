import 'package:dio/dio.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/database/api/api_error_mapper.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/core/shared/models/paginated_response.dart';
import 'package:mindtrip/features/places/data/datasources/place_remote_data_source.dart';
import 'package:mindtrip/core/shared/data/mapper/place_mapper.dart';
import 'package:mindtrip/core/shared/data/datasources/places_local_data_source.dart';
import 'package:mindtrip/features/places/data/models/popular_places_request_model.dart';
import 'package:mindtrip/features/places/data/models/recommendation_places_request_model.dart';
import 'package:mindtrip/features/places/data/models/get_places_request_model.dart';
import 'package:mindtrip/features/places/domain/repositories/place_repository.dart';

class PlaceRepositoryImpl implements PlaceRepository {
  final PlaceRemoteDataSource remoteDataSource;
  final PlacesLocalDataSource localDataSource;

  PlaceRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

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
      if (request.page == 1) {
        await localDataSource.cacheRecommendedPlaces(response.results);
      }
      return Result.ok(response.map((e) => e.toEntity()));
    } catch (e) {
      if (request.page == 1) {
        try {
          final local = await localDataSource.getRecommendedPlaces();
          if (local.isNotEmpty) {
            return Result.ok(PaginatedResponse(
              results: local.map((e) => e.toEntity()).toList(),
              total: local.length,
              page: 1,
              limit: local.length,
              totalPages: 1,
            ));
          }
        } catch (_) {}
      }
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
      if (request.page == 1) {
        await localDataSource.cachePopularPlaces(response.results);
      }
      return Result.ok(response.map((e) => e.toEntity()));
    } catch (e) {
      if (request.page == 1) {
        try {
          final local = await localDataSource.getPopularPlaces();
          if (local.isNotEmpty) {
            return Result.ok(PaginatedResponse(
              results: local.map((e) => e.toEntity()).toList(),
              total: local.length,
              page: 1,
              limit: local.length,
              totalPages: 1,
            ));
          }
        } catch (_) {}
      }
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
  Future<Result<PaginatedResponse<PlaceEntity>>> getPlaces({
    required GetPlacesRequestModel request,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await remoteDataSource.getPlaces(
        request: request,
        cancelToken: cancelToken,
      );
      return Result.ok(response.map((e) => e.toEntity()));
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }
}
