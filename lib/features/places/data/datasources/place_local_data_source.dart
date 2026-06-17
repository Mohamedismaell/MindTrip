import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';

abstract class PlaceLocalDataSource {
  Future<List<PlaceEntity>> getPopularPlaces();
  Future<List<PlaceEntity>> getRecommendedPlaces();
  Future<List<PlaceEntity>> getTrendingPlaces();
  Future<List<PlaceEntity>> getOtherPlaces();
}

class PlaceLocalDataSourceImpl implements PlaceLocalDataSource {
  @override
  Future<List<PlaceEntity>> getPopularPlaces() async {
    return [];
  }

  @override
  Future<List<PlaceEntity>> getRecommendedPlaces() async {
    return [];
  }

  @override
  Future<List<PlaceEntity>> getTrendingPlaces() async {
    return [];
  }

  @override
  Future<List<PlaceEntity>> getOtherPlaces() async {
    return [];
  }
}
