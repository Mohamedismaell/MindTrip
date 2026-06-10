import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/database/api/api_error_mapper.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/features/places/data/datasources/place_local_data_source.dart';
import 'package:mindtrip/features/places/domain/repositories/place_repository.dart';

class PlaceRepositoryImpl implements PlaceRepository {
  final PlaceLocalDataSource localDataSource;

  PlaceRepositoryImpl({required this.localDataSource});

  @override
  Future<Result<List<PlaceEntity>>> getPopularPlaces() async {
    try {
      final places = await localDataSource.getPopularPlaces();
      return Result.ok(places);
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<List<PlaceEntity>>> getRecommendedPlaces() async {
    try {
      final places = await localDataSource.getRecommendedPlaces();
      return Result.ok(places);
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<List<PlaceEntity>>> getTrendingPlaces() async {
    try {
      final places = await localDataSource.getTrendingPlaces();
      return Result.ok(places);
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<List<PlaceEntity>>> getOtherPlaces() async {
    try {
      final places = await localDataSource.getOtherPlaces();
      return Result.ok(places);
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }
}
