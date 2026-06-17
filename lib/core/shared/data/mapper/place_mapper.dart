import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/core/shared/domain/entities/location_entity.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/core/enums/place_category.dart';
import 'package:mindtrip/core/enums/place_badge.dart';

extension PlaceMapper on PlaceModel {
  PlaceEntity toEntity() {
    return PlaceEntity(
      id: placeId,
      name: name,
      description: description,
      location: LocationEntity(
        address: address ?? cityEn ?? city ?? '',
        latitude: lat,
        longitude: lng,
      ),
      imageUrls: imageUrls,
      category: PlaceCategory.fromCategory(category),
      rating: rating,
      reviewCount: reviewsCount,
      price: price ?? cost,
      isFavorite: false, // Default for new models from API
      badge: isHiddenGem ? PlaceBadge.popular : PlaceBadge.none,
    );
  }
}

extension PlaceEntityMapper on PlaceEntity {
  PlaceModel toModel() {
    return PlaceModel(
      placeId: id,
      name: name,
      description: description,
      address: location.address,
      lat: location.latitude ?? 0.0,
      lng: location.longitude ?? 0.0,
      imageUrls: imageUrls,
      category: category.name,
      rating: rating,
      reviewsCount: reviewCount,
      price: price,
      isHiddenGem: badge != PlaceBadge.none,
    );
  }
}
