import '../models/plan_place_model.dart';
import '../../domain/entities/plan_place_entity.dart';

extension PlanPlaceModelMapper on PlanPlaceModel {
  PlanPlaceEntity toEntity() {
    return PlanPlaceEntity(
      placeId: placeId,
      name: name,
      city: city,
      cityEn: cityEn,
      category: category,
      rating: rating,
      reviewsCount: reviewsCount,
      address: address,
      description: description,
      photoUrl: photoUrl,
      imageUrls: imageUrls,
      mapsUrl: mapsUrl,
      lat: lat,
      lng: lng,
      day: day,
      type: type,
      price: price,
      cost: cost,
      interests: interests,
      isHiddenGem: isHiddenGem,
      openingHours: openingHours,
      isOpened: isOpened,
    );
  }
}

extension PlanPlaceEntityMapper on PlanPlaceEntity {
  PlanPlaceModel toModel() {
    return PlanPlaceModel(
      placeId: placeId,
      name: name,
      city: city,
      cityEn: cityEn,
      category: category,
      rating: rating,
      reviewsCount: reviewsCount,
      address: address,
      description: description,
      photoUrl: photoUrl,
      imageUrls: imageUrls,
      mapsUrl: mapsUrl,
      lat: lat,
      lng: lng,
      day: day,
      type: type,
      price: price,
      cost: cost,
      interests: interests,
      isHiddenGem: isHiddenGem,
      openingHours: openingHours,
      isOpened: isOpened,
    );
  }
}
