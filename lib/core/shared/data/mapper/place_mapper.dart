import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/core/shared/domain/entities/location_entity.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/core/enums/place_category.dart';
import 'package:mindtrip/core/enums/place_badge.dart';

extension PlaceMapper on PlaceModel {
  PlaceEntity toEntity() {
    final images = {
      if (photoUrl != null && photoUrl!.isNotEmpty) photoUrl!,
      ...?imageUrls,
    }.toList();

    return PlaceEntity(
      id: placeId,
      name: name,
      description: description,
      location: LocationEntity(
        address: address ?? 'Egypt',
        latitude: lat,
        longitude: lng,
        city: city ?? 'Egypt',
        cityEn: cityEn ?? 'Egypt',
      ),
      imageUrls: images,
      category: PlaceCategory.fromCategory(category),
      rating: rating,
      reviewCount: reviewsCount,
      price: price ?? cost,
      badge: isHiddenGem ? PlaceBadge.popular : PlaceBadge.none,
    );
  }
}
//Todo check to model do we need it later

extension PlaceEntityMapper on PlaceEntity {
  PlaceModel toModel() {
    return PlaceModel(
      placeId: id,
      name: name,
      description: description,
      address: location.address,
      lat: location.latitude,
      lng: location.longitude,
      imageUrls: imageUrls,
      category: category.name,
      rating: rating,
      reviewsCount: reviewCount,
      price: price,
      isHiddenGem: badge != PlaceBadge.none,
    );
  }
}
