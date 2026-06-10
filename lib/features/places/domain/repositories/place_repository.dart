import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';

abstract class PlaceRepository {
  Future<Result<List<PlaceEntity>>> getPopularPlaces();
  Future<Result<List<PlaceEntity>>> getRecommendedPlaces();
  Future<Result<List<PlaceEntity>>> getTrendingPlaces();
  Future<Result<List<PlaceEntity>>> getOtherPlaces();
}
