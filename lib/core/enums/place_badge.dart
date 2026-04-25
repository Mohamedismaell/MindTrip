import 'package:hive_ce_flutter/adapters.dart';

part 'place_badge.g.dart';

@HiveType(typeId: 3)
enum PlaceBadge {
  @HiveField(0)
  topRated,

  @HiveField(1)
  popular,

  @HiveField(2)
  trending,

  @HiveField(3)
  aiCrafted,

  @HiveField(4)
  none,
}

extension PlaceBadgeExtension on PlaceBadge {
  String get name => toString().split('.').last;

  static PlaceBadge fromString(String? badge) {
    return PlaceBadge.values.firstWhere(
      (e) => e.name == badge,
      orElse: () => PlaceBadge.none,
    );
  }
}
