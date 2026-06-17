import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/adapters.dart';

part 'place_category.g.dart';

@HiveType(typeId: 4)
enum PlaceCategory {
  @HiveField(0)
  all,

  @HiveField(1)
  foodCafes,

  @HiveField(2)
  historicalSites,

  @HiveField(3)
  religiousSites,

  @HiveField(4)
  beaches,

  @HiveField(5)
  nature,

  @HiveField(6)
  entertainment,

  @HiveField(7)
  shopping,

  @HiveField(8)
  artsCulture,

  @HiveField(9)
  other;

  // food_cafes
  // historical_sites
  // religious_sites
  // beaches
  // nature
  // entertainment
  // shopping
  // arts_culture
  String get category => switch (this) {
    PlaceCategory.all => 'all',
    PlaceCategory.foodCafes => 'food_cafes',
    PlaceCategory.historicalSites => 'historical_sites',
    PlaceCategory.religiousSites => 'religious_sites',
    PlaceCategory.beaches => 'beaches',
    PlaceCategory.nature => 'nature',
    PlaceCategory.entertainment => 'entertainment',
    PlaceCategory.shopping => 'shopping',
    PlaceCategory.artsCulture => 'arts_culture',
    PlaceCategory.other => 'other',
  };
  String get displayName => switch (this) {
    PlaceCategory.all => 'All',
    PlaceCategory.foodCafes => 'Food & Cafes',
    PlaceCategory.historicalSites => 'Historical Sites',
    PlaceCategory.religiousSites => 'Mosques & Churches',
    PlaceCategory.beaches => 'Beaches & Water',
    PlaceCategory.nature => 'Nature',
    PlaceCategory.entertainment => 'Entertainment',
    PlaceCategory.shopping => 'Shopping',
    PlaceCategory.artsCulture => 'Arts & Culture',
    PlaceCategory.other => 'Other',
  };

  String get emoji => switch (this) {
    PlaceCategory.all => '✨',
    PlaceCategory.foodCafes => '🍽️',
    PlaceCategory.historicalSites => '🏺',
    PlaceCategory.religiousSites => '🏛️',
    PlaceCategory.beaches => '🏖️',
    PlaceCategory.nature => '🌿',
    PlaceCategory.entertainment => '🎭',
    PlaceCategory.shopping => '🛍️',
    PlaceCategory.artsCulture => '🎨',
    PlaceCategory.other => '📍',
  };
  IconData get iconData => switch (this) {
    PlaceCategory.foodCafes => Icons.restaurant_rounded,
    PlaceCategory.historicalSites => Icons.account_balance_rounded,
    PlaceCategory.religiousSites => Icons.church_rounded,
    PlaceCategory.beaches => Icons.beach_access_rounded,
    PlaceCategory.nature => Icons.park_rounded,
    PlaceCategory.entertainment => Icons.attractions_rounded,
    PlaceCategory.shopping => Icons.shopping_bag_rounded,
    PlaceCategory.artsCulture => Icons.palette_rounded,
    _ => Icons.location_on_rounded,
  };

  String get annotationAssetPath => 'assets/images/map/location-pin.png';

  static String get searchPinAssetPath => 'assets/images/map/location-pin.png';

  static PlaceCategory fromCategory(String? category) {
    if (category == null) return PlaceCategory.other;

    return PlaceCategory.values.firstWhere(
      (e) => e.category == category.trim().toLowerCase(),
      orElse: () => PlaceCategory.other,
    );
  }
}
