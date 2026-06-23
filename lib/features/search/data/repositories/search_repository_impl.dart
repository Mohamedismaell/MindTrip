import 'package:dio/dio.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/models/paginated_response.dart';
import 'package:mindtrip/features/places/data/mapper/place_mapper.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/features/search/data/datasources/search_local_data_source.dart';
import 'package:mindtrip/features/search/data/datasources/search_remote_data_source.dart';
import 'package:mindtrip/features/search/data/models/recent_search_model.dart';
import 'package:mindtrip/features/search/data/models/search_places_request_model.dart';
import 'package:mindtrip/features/search/domain/entity/recent_search_entity.dart';
import 'package:mindtrip/features/search/domain/repositories/search_repository.dart';
import 'package:mindtrip/core/database/api/api_error_mapper.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource _remoteDataSource;
  final SearchLocalDataSource _localDataSource;

  SearchRepositoryImpl({
    required SearchRemoteDataSource remoteDataSource,
    required SearchLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  @override
  Future<Result<PaginatedResponse<PlaceEntity>>> searchPlaces({
    required SearchPlacesRequestModel request,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _remoteDataSource.searchPlaces(
        request: request,
        cancelToken: cancelToken,
      );

      final results = PaginatedResponse<PlaceEntity>(
        total: response.total,
        page: response.page,
        limit: response.limit,
        totalPages: response.totalPages,
        results: response.results.map((e) => e.toEntity()).toList(),
      );

      return Result.ok(results);
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
  Future<Result<List<RecentSearchEntity>>> getRecentSearches() async {
    try {
      final results = await _localDataSource.getRecentSearches();
      return Result.ok(results.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<void>> saveRecentSearch(RecentSearchEntity entity) async {
    try {
      await _localDataSource.saveRecentSearch(
        RecentSearchModel.fromEntity(entity),
      );
      return const Result.ok(null);
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<void>> clearRecentSearches() async {
    try {
      await _localDataSource.clearRecentSearches();
      return const Result.ok(null);
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }
}
