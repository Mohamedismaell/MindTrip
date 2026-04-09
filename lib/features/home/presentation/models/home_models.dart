class HomeCategory {
  final String emoji;
  final String label;
  final bool isSelected;

  const HomeCategory({
    required this.emoji,
    required this.label,
    this.isSelected = false,
  });
}

class HomeBanner {
  final String title;
  final String imageUrl;

  const HomeBanner({
    required this.title,
    required this.imageUrl,
  });
}

class HomeSpotlight {
  final String title;
  final String location;
  final String imageUrl;
  final List<String> previewImageUrls;
  final int extraPhotoCount;

  const HomeSpotlight({
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.previewImageUrls,
    required this.extraPhotoCount,
  });
}

class HomeDestination {
  final String title;
  final String location;
  final String imageUrl;
  final String priceTag;

  const HomeDestination({
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.priceTag,
  });
}

class HomePackage {
  final String title;
  final String location;
  final String imageUrl;
  final String price;
  final double rating;

  const HomePackage({
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.price,
    required this.rating,
  });
}

class PlannerStop {
  final String time;
  final String label;

  const PlannerStop({
    required this.time,
    required this.label,
  });
}

class PlannerPreview {
  final String title;
  final String imageUrl;
  final List<PlannerStop> stops;
  final String badge;

  const PlannerPreview({
    required this.title,
    required this.imageUrl,
    required this.stops,
    required this.badge,
  });
}
