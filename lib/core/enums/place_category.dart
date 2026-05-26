import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/adapters.dart';

part 'place_category.g.dart';

@HiveType(typeId: 4)
enum PlaceCategory {
  @HiveField(0)
  all,
  @HiveField(1)
  hotel,
  @HiveField(2)
  restaurant,
  @HiveField(3)
  beach,
  @HiveField(4)
  mountain,
  @HiveField(5)
  desert,
  @HiveField(6)
  diving,
  @HiveField(7)
  trip,
  @HiveField(8)
  activity,
  @HiveField(9)
  park,
  @HiveField(10)
  museum,
  @HiveField(11)
  shopping,
  @HiveField(12)
  entertainment,
  @HiveField(13)
  heritage,
  @HiveField(14)
  camping,
  @HiveField(15)
  wellness,
  @HiveField(16)
  cafe,
  @HiveField(17)
  other;

  String get displayName => switch (this) {
    PlaceCategory.all => 'All',
    PlaceCategory.hotel => 'Hotels',
    PlaceCategory.restaurant => 'Restaurants',
    PlaceCategory.beach => 'Beach',
    PlaceCategory.mountain => 'Mountain',
    PlaceCategory.desert => 'Desert',
    PlaceCategory.diving => 'Diving',
    PlaceCategory.trip => 'Trips',
    PlaceCategory.activity => 'Activities',
    PlaceCategory.park => 'Parks',
    PlaceCategory.museum => 'Museums',
    PlaceCategory.shopping => 'Shopping',
    PlaceCategory.entertainment => 'Entertainment',
    PlaceCategory.heritage => 'Heritage',
    PlaceCategory.camping => 'Camping',
    PlaceCategory.wellness => 'Wellness',
    PlaceCategory.cafe => 'Cafe',
    PlaceCategory.other => 'Other',
  };

  String get emoji => switch (this) {
    PlaceCategory.all => '✨',
    PlaceCategory.hotel => '🏨',
    PlaceCategory.restaurant => '🍽️',
    PlaceCategory.beach => '🏖️',
    PlaceCategory.mountain => '⛰️',
    PlaceCategory.desert => '🏜️',
    PlaceCategory.diving => '🤿',
    PlaceCategory.trip => '✈️',
    PlaceCategory.activity => '🎯',
    PlaceCategory.park => '🌳',
    PlaceCategory.museum => '🏛️',
    PlaceCategory.shopping => '🛍️',
    PlaceCategory.entertainment => '🎭',
    PlaceCategory.heritage => '🏛️',
    PlaceCategory.camping => '🏕️',
    PlaceCategory.wellness => '🧘',
    PlaceCategory.cafe => '☕',
    PlaceCategory.other => '📍',
  };

  IconData get iconData => switch (this) {
    PlaceCategory.hotel => Icons.hotel_rounded,
    PlaceCategory.restaurant => Icons.restaurant_rounded,
    PlaceCategory.beach => Icons.beach_access_rounded,
    PlaceCategory.mountain => Icons.landscape_rounded,
    PlaceCategory.desert => Icons.wb_sunny_rounded,
    PlaceCategory.diving => Icons.scuba_diving_rounded,
    PlaceCategory.trip => Icons.flight_rounded,
    PlaceCategory.activity => Icons.directions_bike_rounded,
    PlaceCategory.park => Icons.park_rounded,
    PlaceCategory.museum => Icons.museum_rounded,
    PlaceCategory.shopping => Icons.shopping_bag_rounded,
    PlaceCategory.entertainment => Icons.attractions_rounded,
    PlaceCategory.heritage => Icons.account_balance_rounded,
    PlaceCategory.camping => Icons.holiday_village_rounded,
    PlaceCategory.wellness => Icons.spa_rounded,
    PlaceCategory.cafe => Icons.local_cafe_rounded,
    _ => Icons.location_on_rounded,
  };

  String get annotationAssetPath => 'assets/images/map/location-pin.png';

  static String get searchPinAssetPath => 'assets/images/map/location-pin.png';

  static PlaceCategory fromCategory(String? category) {
    if (category == null) return PlaceCategory.other;
    return PlaceCategory.values.firstWhere(
      (e) => e.name.toLowerCase().trim() == category.toLowerCase().trim(),
      orElse: () => PlaceCategory.other,
    );
  }
}
