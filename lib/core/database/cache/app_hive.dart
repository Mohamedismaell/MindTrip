import 'package:hive_ce_flutter/adapters.dart';
import 'package:mindtrip/core/enums/place_badge.dart';
import 'package:mindtrip/core/enums/place_category.dart';
import 'package:mindtrip/core/shared/data/models/location_model.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/features/ai_planner/data/models/trip_model.dart';

class AppHive {
  static late Box onboardingBox;
  static late Box<String> favoritesBox;
  static late Box<String> favoritesSyncQueueBox;
  static late Box<PlaceModel> placesCacheBox;
  static late Box<TripModel> tripsBox;
  static late Box<String> itinerariesBox;

  static Future<void> init() async {
    await Hive.initFlutter();
    registerAdapters();
    await openBoxes();
  }

  static void registerAdapters() {
    if (!Hive.isAdapterRegistered(PlaceBadgeAdapter().typeId)) {
      Hive.registerAdapter(PlaceBadgeAdapter());
    }
    if (!Hive.isAdapterRegistered(LocationModelAdapter().typeId)) {
      Hive.registerAdapter(LocationModelAdapter());
    }
    if (!Hive.isAdapterRegistered(PlaceModelAdapter().typeId)) {
      Hive.registerAdapter(PlaceModelAdapter());
    }
    if (!Hive.isAdapterRegistered(PlaceCategoryAdapter().typeId)) {
      Hive.registerAdapter(PlaceCategoryAdapter());
    }
    if (!Hive.isAdapterRegistered(TripModelAdapter().typeId)) {
      Hive.registerAdapter(TripModelAdapter());
    }
  }

  static Future<void> openBoxes() async {
    onboardingBox = await Hive.openBox('onboardingBox');
    favoritesBox = await Hive.openBox('favoritesBox');
    favoritesSyncQueueBox = await Hive.openBox('favoritesSyncQueueBox');
    placesCacheBox = await Hive.openBox('placesCacheBox');
    tripsBox = await Hive.openBox('tripsBox');
    itinerariesBox = await Hive.openBox<String>('itinerariesBox');
  }

  static Future<void> clearBoxes() async {
    await onboardingBox.clear();
    favoritesBox.clear();
    favoritesSyncQueueBox.clear();
    placesCacheBox.clear();
    tripsBox.clear();
    itinerariesBox.clear();
  }
}
