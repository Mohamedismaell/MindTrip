import 'package:hive_ce_flutter/adapters.dart';
import 'package:mindtrip/core/enums/place_badge.dart';
import 'package:mindtrip/core/shared/data/models/location_model.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';

class AppHive {
  static late Box<bool> onboardingBox;
  static late Box<String> favoritesBox;
  static late Box<String> favoritesSyncQueueBox;
  static late Box<PlaceModel> placesCacheBox;

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
  }

  static Future<void> openBoxes() async {
    onboardingBox = await Hive.openBox('onboardingBox');
    favoritesBox = await Hive.openBox('favoritesBox');
    favoritesSyncQueueBox = await Hive.openBox('favoritesSyncQueueBox');
    placesCacheBox = await Hive.openBox('placesCacheBox');
  }
}
