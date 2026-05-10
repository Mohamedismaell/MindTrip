enum PlaceCategory {
  restaurant,
  hotel,
  beach,
  park,
  museum,
  shopping,
  entertainment,
  hospital,
  education,
  other;

  static PlaceCategory fromCategoryId(String? id) {
    if (id == null) return PlaceCategory.other;
    return PlaceCategory.values.firstWhere(
      (e) => e.name.toLowerCase() == id.toLowerCase(),
      orElse: () => PlaceCategory.other,
    );
  }

  String get label {
    switch (this) {
      case PlaceCategory.restaurant:
        return 'Restaurant';
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
      case PlaceCategory.hospital:
        return 'Hospital';
      case PlaceCategory.education:
        return 'Education';
      case PlaceCategory.other:
        return 'Other';
    }
  }

  String get annotationAssetPath {
    switch (this) {
      case PlaceCategory.restaurant:
        return 'assets/images/map/Component 23.png';
      case PlaceCategory.hotel:
        return 'assets/images/map/Component 23.png';
      case PlaceCategory.beach:
        return 'assets/images/map/Component 23.png';
      case PlaceCategory.park:
        return 'assets/images/map/Component 23.png';
      case PlaceCategory.museum:
        return 'assets/images/map/Component 23.png';
      case PlaceCategory.shopping:
        return 'assets/images/map/Component 23.png';
      case PlaceCategory.entertainment:
        return 'assets/images/map/Component 23.png';
      case PlaceCategory.hospital:
        return 'assets/images/map/Component 23.png';
      case PlaceCategory.education:
        return 'assets/images/map/Component 23.png';
      case PlaceCategory.other:
        return 'assets/images/map/Component 23.png';
    }
  }

  static String get searchPinAssetPath => 'assets/images/map/Component 23.png';
}
