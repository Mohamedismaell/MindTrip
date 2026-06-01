import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/features/explore/presentation/data/explore_mock_data.dart';
import 'package:mindtrip/features/home/presentation/data/home_mock_data.dart';
import 'package:mindtrip/core/shared/data/mapper/place_mapper.dart';

class PlaceDetailsRemoteDataSource {

  PlaceDetailsRemoteDataSource();

  Future<PlaceModel> getPlaceDetails(String placeId) async {
    /// TODO: Make real API call when backend connects place details endpoints
    // final response = await _api.get(EndPoints.placeDetails(placeId));
    // return PlaceModel.fromJson(response);

    // Mock fallback: search all mock data lists to return a valid PlaceModel
    await Future.delayed(const Duration(milliseconds: 2500));

    final List<PlaceModel> allMockPlaces = [
      ...HomeMockData.popularDestinations.map((e) => e.toModel()),
      ...HomeMockData.recommendedDestinations.map((e) => e.toModel()),
      ...ExploreMockData.trendingPlaces.map((e) => e.toModel()),
      ...ExploreMockData.otherPlaces.map((e) => e.toModel()),
    ];

    try {
      return allMockPlaces.firstWhere((p) => p.id == placeId);
    } catch (_) {
      throw Exception('Place not found in mock data: $placeId');
    }
  }

  Future<List<PlaceModel>> getNearbyPlaces(
      String placeId, {
      double? lat,
      double? lng,
  }) async {
    /// TODO: Make real API call when backend connects nearby places endpoints
    // final response = await _api.get(
    //   EndPoints.nearbyPlaces(placeId),
    //   queryParameters: {
    //     if (lat != null) 'lat': lat,
    //     if (lng != null) 'lng': lng,
    //   },
    // );
    // return (response as List).map((json) => PlaceModel.fromJson(json)).toList();

    // Mock fallback: return a shuffled sublist of trending places
    await Future.delayed(const Duration(seconds: 5));
    final List<PlaceModel> nearby = List.from(ExploreMockData.trendingPlaces.map((e) => e.toModel()));
    nearby.shuffle();
    return nearby.take(4).toList();
  }
}
