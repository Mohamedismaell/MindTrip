import 'package:dio/dio.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/database/api/api_error_mapper.dart';
import 'package:mindtrip/features/places/data/mapper/place_mapper.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/core/shared/models/paginated_response.dart';
import 'package:mindtrip/features/places/data/datasources/place_remote_data_source.dart';
import 'package:mindtrip/features/places/data/datasources/place_local_data_source.dart';
import 'package:mindtrip/features/places/data/models/popular_places_request_model.dart';
import 'package:mindtrip/features/places/data/models/recommendation_places_request_model.dart';
import 'package:mindtrip/features/places/data/models/get_places_request_model.dart';
import 'package:mindtrip/features/places/data/models/nearby_places_request_model.dart';
import 'package:mindtrip/features/places/domain/repositories/place_repository.dart';

class PlaceRepositoryImpl implements PlaceRepository {
  final PlaceRemoteDataSource remoteDataSource;
  final PlaceLocalDataSource localDataSource;

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
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        return const Result.cancelled();
      }
      return _getRecommendedLocalFallback(request, e);
    } catch (e) {
      return _getRecommendedLocalFallback(request, e);
    }
  }

  Future<Result<PaginatedResponse<PlaceEntity>>> _getRecommendedLocalFallback(
    RecommendationPlacesRequestModel request,
    Object e,
  ) async {
    if (request.page == 1) {
      try {
        final local = await localDataSource.getRecommendedPlaces();
        if (local.isNotEmpty) {
          return Result.ok(
            PaginatedResponse(
              results: local.map((e) => e.toEntity()).toList(),
              total: local.length,
              page: 1,
              limit: local.length,
              totalPages: 1,
            ),
          );
        }
      } catch (_) {}
    }
    return Result.error(ApiErrorMapper.fromException(e));
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
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        return const Result.cancelled();
      }
      return _getPopularLocalFallback(request, e);
    } catch (e) {
      return _getPopularLocalFallback(request, e);
    }
  }

  Future<Result<PaginatedResponse<PlaceEntity>>> _getPopularLocalFallback(
    PopularPlacesRequestModel request,
    Object e,
  ) async {
    if (request.page == 1) {
      try {
        final local = await localDataSource.getPopularPlaces();
        if (local.isNotEmpty) {
          return Result.ok(
            PaginatedResponse(
              results: local.map((e) => e.toEntity()).toList(),
              total: local.length,
              page: 1,
              limit: local.length,
              totalPages: 1,
            ),
          );
        }
      } catch (_) {}
    }
    return Result.error(ApiErrorMapper.fromException(e));
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
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        return const Result.cancelled();
      }
      return Result.error(ApiErrorMapper.fromException(e));
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
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        return const Result.cancelled();
      }
      return Result.error(ApiErrorMapper.fromException(e));
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<PaginatedResponse<PlaceEntity>>> getNearbyPlaces({
    required NearbyPlacesRequestModel request,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await remoteDataSource.getNearbyPlaces(
        request: request,
        cancelToken: cancelToken,
      );
      if (request.page == 1) {
        await localDataSource.cacheNearbyPlaces(
          response.results,
          request.userLat,
          request.userLng,
        );
      }
      return Result.ok(response.map((e) => e.toEntity()));
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        return const Result.cancelled();
      }
      return _getNearbyLocalFallback(request, e);
    } catch (e) {
      return _getNearbyLocalFallback(request, e);
    }
  }

  Future<Result<PaginatedResponse<PlaceEntity>>> _getNearbyLocalFallback(
    NearbyPlacesRequestModel request,
    Object e,
  ) async {
    if (request.page == 1) {
      try {
        final local = await localDataSource.getNearbyPlaces(
          request.userLat,
          request.userLng,
        );
        if (local.isNotEmpty) {
          return Result.ok(
            PaginatedResponse(
              results: local.map((e) => e.toEntity()).toList(),
              total: local.length,
              page: 1,
              limit: local.length,
              totalPages: 1,
            ),
          );
        }
      } catch (_) {}
    }
    return Result.error(ApiErrorMapper.fromException(e));
  }
}
