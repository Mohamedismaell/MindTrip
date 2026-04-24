enum PlaceBadge { topRated, popular, trending, aiCrafted, none }

extension PlaceBadgeExtension on PlaceBadge {
  String get name {
    return switch (this) {
      PlaceBadge.topRated => 'topRated',
      PlaceBadge.popular => 'popular',
      PlaceBadge.trending => 'trending',
      PlaceBadge.aiCrafted => 'aiCrafted',
      PlaceBadge.none => 'none',
    };
  }

  static PlaceBadge fromString(String badge) {
    return switch (badge) {
      'topRated' => PlaceBadge.topRated,
      'popular' => PlaceBadge.popular,
      'trending' => PlaceBadge.trending,
      'aiCrafted' => PlaceBadge.aiCrafted,
      _ => PlaceBadge.none,
    };
  }
}
