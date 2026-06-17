import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/database/api/api_error_mapper.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/core/shared/models/paginated_response.dart';
import 'package:mindtrip/features/places/data/datasources/place_remote_data_source.dart';
import 'package:mindtrip/core/shared/data/mapper/place_mapper.dart';
import 'package:mindtrip/features/places/data/models/popular_request_model.dart';
import 'package:mindtrip/features/places/data/models/recommendation_request_model.dart';
import 'package:mindtrip/features/places/domain/repositories/place_repository.dart';

class PlaceRepositoryImpl implements PlaceRepository {
  final PlaceRemoteDataSource remoteDataSource;

  PlaceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<PaginatedResponse<PlaceEntity>>> getRecommendedPlaces(
    RecommendationRequestModel request,
  ) async {
    try {
      final response = await remoteDataSource.getRecommendedPlaces(request);
      return Result.ok(response.map((e) => e.toEntity()));
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<PaginatedResponse<PlaceEntity>>> getPopularPlaces(
    PopularRequestModel request,
  ) async {
    try {
      final response = await remoteDataSource.getPopularPlaces(request);
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
  }) async {
    try {
      final response = await remoteDataSource.searchPlaces(
        query: query,
        filters: filters,
        page: page,
        limit: limit,
      );
      return Result.ok(response.map((e) => e.toEntity()));
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
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
  }) async {
    try {
      final response = await remoteDataSource.getPlaces(
        filters: filters,
        city: city,
        category: category,
        interests: interests,
        minRating: minRating,
        maxRating: maxRating,
        minPrice: minPrice,
        maxPrice: maxPrice,
        hiddenGem: hiddenGem,
        sortBy: sortBy,
        order: order,
        page: page,
        limit: limit,
      );
      return Result.ok(response.map((e) => e.toEntity()));
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }
}
