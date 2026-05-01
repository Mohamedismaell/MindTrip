enum PlaceCategory {
  restaurant,
  landmark,
  hotel,
  beach,
  park,
  museum,
  shopping,
  entertainment,
  other;

  static PlaceCategory fromCategoryId(String? id) {
    if (id == null) return PlaceCategory.other;
    return PlaceCategory.values.firstWhere(
      (e) => e.name.toLowerCase() == id.toLowerCase(),
      orElse: () => PlaceCategory.other,
    );
  }

  String get iconAssetPath => 'assets/icons/map/${name}.png';

  String get label {
    switch (this) {
      case PlaceCategory.restaurant:
        return 'Restaurant';
      case PlaceCategory.landmark:
        return 'Landmark';
      case PlaceCategory.hotel:
        return 'Hotel';
      case PlaceCategory.beach:
        return 'Beach';
      case PlaceCategory.park:
        return 'Park';
      case PlaceCategory.museum:
        return 'Museum';
      case PlaceCategory.shopping:
        return 'Shopping';
      case PlaceCategory.entertainment:
        return 'Entertainment';
      case PlaceCategory.other:
        return 'Other';
    }
  }
}
