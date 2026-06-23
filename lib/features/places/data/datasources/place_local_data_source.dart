import 'package:hive_ce_flutter/adapters.dart';
import 'package:mindtrip/core/database/cache/app_hive.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';

abstract class PlaceLocalDataSource {
  Future<void> cachePlace(PlaceModel place);
  Future<void> cachePlaces(List<PlaceModel> places);
  Future<PlaceModel?> getPlace(String id);
  Future<List<PlaceModel>> getPlaces(List<String> ids);

  Future<void> cachePopularPlaces(List<PlaceModel> places);
  Future<List<PlaceModel>> getPopularPlaces();

  Future<void> cacheRecommendedPlaces(List<PlaceModel> places);
  Future<List<PlaceModel>> getRecommendedPlaces();

  Future<void> cacheNearbyPlaces(
    List<PlaceModel> places,
    double userLat,
    double userLng,
  );
  Future<List<PlaceModel>> getNearbyPlaces(double userLat, double userLng);
}

class PlacesLocalDataSourceImpl implements PlaceLocalDataSource {
  final Box<PlaceModel> _placesCacheBox;

  PlacesLocalDataSourceImpl() : _placesCacheBox = AppHive.placesCacheBox;

  @override
  Future<void> cachePlace(PlaceModel place) async {
    await _placesCacheBox.put(place.id, place);
  }

  @override
  Future<void> cachePlaces(List<PlaceModel> places) async {
    final Map<String, PlaceModel> entries = {};
    for (PlaceModel place in places) {
      entries[place.id] = place;
    }
    await _placesCacheBox.putAll(entries);
  }

  @override
  Future<PlaceModel?> getPlace(String id) async {
    return _placesCacheBox.get(id);
  }

  @override
  Future<List<PlaceModel>> getPlaces(List<String> ids) async {
    final List<PlaceModel> places = [];
    for (String id in ids) {
      final PlaceModel? place = await getPlace(id);
      if (place != null) {
        places.add(place);
      }
    }
    return places;
  }

  @override
  Future<void> cachePopularPlaces(List<PlaceModel> places) async {
    await cachePlaces(places);
    await AppHive.metadataBox.put(
      'popular_places',
      places.map((e) => e.id).toList(),
    );
  }

  @override
  Future<List<PlaceModel>> getPopularPlaces() async {
    final ids = AppHive.metadataBox.get('popular_places');
    if (ids == null) return [];
    return getPlaces(ids);
  }

  @override
  Future<void> cacheRecommendedPlaces(List<PlaceModel> places) async {
    await cachePlaces(places);
    await AppHive.metadataBox.put(
      'recommended_places',
      places.map((e) => e.id).toList(),
    );
  }

  @override
  Future<List<PlaceModel>> getRecommendedPlaces() async {
    final ids = AppHive.metadataBox.get('recommended_places');
    if (ids == null) return [];
    return getPlaces(ids);
  }

  @override
  Future<void> cacheNearbyPlaces(
    List<PlaceModel> places,
    double userLat,
    double userLng,
  ) async {
    await cachePlaces(places);
    await AppHive.metadataBox.put(
      'nearby_places_$userLat$userLng',
      places.map((e) => e.id).toList(),
    );
  }

  @override
  Future<List<PlaceModel>> getNearbyPlaces(
    double userLat,
    double userLng,
  ) async {
    final ids = AppHive.metadataBox.get('nearby_places_$userLat$userLng');
    if (ids == null) return [];
    return getPlaces(ids);
  }
}
