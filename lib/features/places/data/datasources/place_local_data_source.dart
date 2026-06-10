import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/features/home/presentation/data/home_mock_data.dart';
import 'package:mindtrip/features/explore/presentation/data/explore_mock_data.dart';

abstract class PlaceLocalDataSource {
  Future<List<PlaceEntity>> getPopularPlaces();
  Future<List<PlaceEntity>> getRecommendedPlaces();
  Future<List<PlaceEntity>> getTrendingPlaces();
  Future<List<PlaceEntity>> getOtherPlaces();
}

class PlaceLocalDataSourceImpl implements PlaceLocalDataSource {
  @override
  Future<List<PlaceEntity>> getPopularPlaces() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return HomeMockData.popularDestinations;
  }

  @override
  Future<List<PlaceEntity>> getRecommendedPlaces() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return HomeMockData.recommendedDestinations;
  }

  @override
  Future<List<PlaceEntity>> getTrendingPlaces() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return ExploreMockData.trendingPlaces;
  }

  @override
  Future<List<PlaceEntity>> getOtherPlaces() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return ExploreMockData.otherPlaces;
  }
}
