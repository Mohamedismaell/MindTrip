import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/features/explore/presentation/models/explore_models.dart';

class ExploreMockData {
  const ExploreMockData._();

  // static const categories = [
  //   PlaceCategory.all,
  //   PlaceCategory.foodCafes,
  //   PlaceCategory.historicalSites,
  //   PlaceCategory.beaches,
  //   PlaceCategory.nature,
  //   PlaceCategory.entertainment,
  //   PlaceCategory.shopping,
  //   PlaceCategory.artsCulture,
  // ];

  static const tabs = [
    ExploreTab(label: 'All', isSelected: true),
    ExploreTab(label: 'Places', isSelected: false),
    ExploreTab(label: 'Trips', isSelected: false),
    ExploreTab(label: 'Activities', isSelected: false),
  ];

  static const List<PlaceEntity> trendingPlaces = [];
  static const List<PlaceEntity> otherPlaces = [];
}
