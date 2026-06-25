import 'package:hive_ce_flutter/adapters.dart';
import 'package:mindtrip/core/enums/place_badge.dart';
import 'package:mindtrip/core/enums/place_category.dart';
import 'package:mindtrip/core/shared/data/models/location_model.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/core/shared/data/models/banner_model.dart';
import 'package:mindtrip/core/shared/data/models/planner_preview_model.dart';
import 'package:mindtrip/features/trips/data/models/trip_model.dart';
import 'package:mindtrip/features/search/data/models/recent_search_model.dart';

class AppHive {
  static late Box onboardingBox;
  static late Box<PlaceModel> favoritesBox;
  static late Box<String> favoritesSyncQueueBox;
  static late Box<PlaceModel> placesCacheBox;
  static late Box<TripModel> tripsBox;
  static late Box<String> itinerariesBox;
  static late Box planningSessionsBox;
  static late Box<BannerModel> bannersBox;
  static late Box<PlannerPreviewModel> plannerPreviewsBox;
  static late Box<List<String>> metadataBox;
  static late Box<RecentSearchModel> recentSearchBox;

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
    // if (!Hive.isAdapterRegistered(TripModelAdapter().typeId)) {
    //   Hive.registerAdapter(TripModelAdapter());
    // }
    if (!Hive.isAdapterRegistered(BannerModelAdapter().typeId)) {
      Hive.registerAdapter(BannerModelAdapter());
    }
    if (!Hive.isAdapterRegistered(PlannerStopModelAdapter().typeId)) {
      Hive.registerAdapter(PlannerStopModelAdapter());
    }
    if (!Hive.isAdapterRegistered(PlannerPreviewModelAdapter().typeId)) {
      Hive.registerAdapter(PlannerPreviewModelAdapter());
    }
    if (!Hive.isAdapterRegistered(RecentSearchModelAdapter().typeId)) {
      Hive.registerAdapter(RecentSearchModelAdapter());
    }
  }

  static Future<void> openBoxes() async {
    onboardingBox = await Hive.openBox('onboardingBox');
    favoritesBox = await Hive.openBox<PlaceModel>('favoritesBox');
    favoritesSyncQueueBox = await Hive.openBox('favoritesSyncQueueBox');
    placesCacheBox = await Hive.openBox('placesCacheBox');
    tripsBox = await Hive.openBox('tripsBox');
    itinerariesBox = await Hive.openBox<String>('itinerariesBox');
    planningSessionsBox = await Hive.openBox('planning_sessions');
    bannersBox = await Hive.openBox<BannerModel>('bannersBox');
    plannerPreviewsBox = await Hive.openBox<PlannerPreviewModel>(
      'plannerPreviewsBox',
    );
    metadataBox = await Hive.openBox<List<String>>('metadataBox');
    recentSearchBox = await Hive.openBox<RecentSearchModel>('recentSearchBox');
  }

  static Future<void> clearBoxes() async {
    favoritesBox.clear();
    favoritesSyncQueueBox.clear();
    placesCacheBox.clear();
    tripsBox.clear();
    itinerariesBox.clear();
    planningSessionsBox.clear();
    bannersBox.clear();
    plannerPreviewsBox.clear();
    metadataBox.clear();
    recentSearchBox.clear();
  }
}
