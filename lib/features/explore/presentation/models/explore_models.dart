enum ExploreBadge { topRated, popular, trending, none }

class ExploreCategory {
  final String emoji;
  final String label;
  final bool isSelected;

  const ExploreCategory({
    required this.emoji,
    required this.label,
    this.isSelected = false,
  });

  ExploreCategory copyWith({bool? isSelected}) => ExploreCategory(
    emoji: emoji,
    label: label,
    isSelected: isSelected ?? this.isSelected,
  );
}

class ExploreTab {
  final String label;
  final bool isSelected;

  const ExploreTab({required this.label, this.isSelected = false});

  ExploreTab copyWith({bool? isSelected}) =>
      ExploreTab(label: label, isSelected: isSelected ?? this.isSelected);
}

class ExplorePlace {
  final String title;
  final String location;
  final String imageUrl;
  final double? rating;
  final String price;
  final ExploreBadge badge;
  final bool isFavorite;

  const ExplorePlace({
    required this.title,
    required this.location,
    required this.imageUrl,
    this.rating,
    required this.price,
    this.badge = ExploreBadge.none,
    this.isFavorite = false,
  });
}

class ExploreTrending {
  final String title;
  final String imageUrl;

  const ExploreTrending({required this.title, required this.imageUrl});
}
