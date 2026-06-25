import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/adapters.dart';

part 'place_category.g.dart';

@HiveType(typeId: 4)
enum PlaceCategory {
  @HiveField(0)
  all,

  @HiveField(1)
  food,

  @HiveField(2)
  cafes,

  @HiveField(3)
  historicalSites,

  @HiveField(4)
  religiousSites,

  @HiveField(5)
  beaches,

  @HiveField(6)
  nature,

  @HiveField(7)
  entertainment,

  @HiveField(8)
  shopping,

  @HiveField(9)
  artsCulture,

  @HiveField(10)
  hotels;

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
    PlaceCategory.food => 'food',
    PlaceCategory.cafes => 'cafe',
    PlaceCategory.historicalSites => 'historical_sites',
    PlaceCategory.religiousSites => 'religious_sites',
    PlaceCategory.beaches => 'beaches',
    PlaceCategory.nature => 'nature',
    PlaceCategory.entertainment => 'entertainment',
    PlaceCategory.shopping => 'shopping',
    PlaceCategory.artsCulture => 'arts_culture',
    PlaceCategory.hotels => 'hotels',
  };
  String get displayName => switch (this) {
    PlaceCategory.all => 'All',
    PlaceCategory.food => 'Food',
    PlaceCategory.cafes => 'Cafes',
    PlaceCategory.historicalSites => 'Historical Sites',
    PlaceCategory.religiousSites => 'Mosques & Churches',
    PlaceCategory.beaches => 'Beaches & Water',
    PlaceCategory.nature => 'Nature',
    PlaceCategory.entertainment => 'Entertainment',
    PlaceCategory.shopping => 'Shopping',
    PlaceCategory.artsCulture => 'Arts & Culture',
    PlaceCategory.hotels => 'Hotels',
  };

  String get emoji => switch (this) {
    PlaceCategory.all => '✨',
    PlaceCategory.food => '🍽️',
    PlaceCategory.cafes => '☕',
    PlaceCategory.historicalSites => '🏺',
    PlaceCategory.religiousSites => '🏛️',
    PlaceCategory.beaches => '🏖️',
    PlaceCategory.nature => '🌿',
    PlaceCategory.entertainment => '🎭',
    PlaceCategory.shopping => '🛍️',
    PlaceCategory.artsCulture => '🎨',
    PlaceCategory.hotels => '🏨',
  };

  IconData get iconData => switch (this) {
    PlaceCategory.food => Icons.restaurant_rounded,
    PlaceCategory.cafes => Icons.coffee_rounded,
    PlaceCategory.historicalSites => Icons.account_balance_rounded,
    PlaceCategory.religiousSites => Icons.church_rounded,
    PlaceCategory.beaches => Icons.beach_access_rounded,
    PlaceCategory.nature => Icons.park_rounded,
    PlaceCategory.entertainment => Icons.attractions_rounded,
    PlaceCategory.shopping => Icons.shopping_bag_rounded,
    PlaceCategory.artsCulture => Icons.palette_rounded,
    PlaceCategory.hotels => Icons.hotel_rounded,
    _ => Icons.location_on_rounded,
  };

  String get annotationAssetPath => 'assets/images/map/location-pin.png';

  static String get searchPinAssetPath => 'assets/images/map/location-pin.png';

  static PlaceCategory fromCategory(String? category) {
    if (category == null) return PlaceCategory.all;

    return PlaceCategory.values.firstWhere(
      (e) => e.category == category.trim().toLowerCase(),
      orElse: () => PlaceCategory.all,
    );
  }
}

extension PlaceCategoryColor on PlaceCategory {
  Color get color {
    switch (this) {
      case PlaceCategory.all:
        return const Color(0xFF6B7280); // Gray

      case PlaceCategory.food:
        return const Color(0xFFFF7043); // Orange

      case PlaceCategory.cafes:
        return const Color(0xFF8D6E63); // Coffee Brown

      case PlaceCategory.historicalSites:
        return const Color(0xFFC9A227); // Gold

      case PlaceCategory.religiousSites:
        return const Color(0xFF5E35B1); // Purple

      case PlaceCategory.beaches:
        return const Color(0xFF29B6F6); // Sky Blue

      case PlaceCategory.nature:
        return const Color(0xFF43A047); // Green

      case PlaceCategory.entertainment:
        return const Color(0xFFE91E63); // Pink

      case PlaceCategory.shopping:
        return const Color(0xFF7E57C2); // Violet

      case PlaceCategory.artsCulture:
        return const Color(0xFF00897B); // Teal

      case PlaceCategory.hotels:
        return const Color(0xFF1565C0); // Royal Blue
    }
  }
}

extension PlaceCategoryChipColor on PlaceCategory {
  Color get backgroundColor => color.withValues(alpha: 0.12);
}
