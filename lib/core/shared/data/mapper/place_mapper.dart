import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'location_mapper.dart';

extension PlaceMapper on PlaceModel {
  PlaceEntity toEntity() {
    return PlaceEntity(
      id: id,
      name: name,
      description: description,
      location: location.toEntity(),
      imageUrls: imageUrls,
      category: category,
      rating: rating,
      reviewCount: reviewCount,
      price: price,
      isFavorite: isFavorite,
      badge: badge,
    );
  }
}

extension PlaceEntityMapper on PlaceEntity {
  PlaceModel toModel() {
    return PlaceModel(
      id: id,
      name: name,
      description: description,
      location: location.toModel(),
      imageUrls: imageUrls,
      category: category,
      rating: rating,
      reviewCount: reviewCount,
      price: price,
      isFavorite: isFavorite,
      badge: badge,
    );
  }
}
