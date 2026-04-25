import 'package:hive_ce_flutter/adapters.dart';
import 'package:mindtrip/core/database/cache/app_hive.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';

abstract class PlacesLocalDataSource {
  Future<void> cachePlace(PlaceModel place);
  Future<void> cachePlaces(List<PlaceModel> places);
  Future<PlaceModel?> getPlace(String id);
  Future<List<PlaceModel>> getPlaces(List<String> ids);
}

class PlacesLocalDataSourceImpl implements PlacesLocalDataSource {
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
}
