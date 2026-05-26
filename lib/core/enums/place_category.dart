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

  String get annotationAssetPath => 'assets/images/map/location-pin.webp';

  static String get searchPinAssetPath => 'assets/images/map/location-pin.webp';

  static PlaceCategory fromCategory(String? category) {
    if (category == null) return PlaceCategory.other;
    return PlaceCategory.values.firstWhere(
      (e) => e.name.toLowerCase().trim() == category.toLowerCase().trim(),
      orElse: () => PlaceCategory.other,
    );
  }
}
