import 'package:mindtrip/core/shared/data/models/review_model.dart';
import 'package:mindtrip/core/shared/domain/entities/review_entity.dart';

extension ReviewMapper on ReviewModel {
  ReviewEntity toEntity() {
    return ReviewEntity(
      id: id,
      userId: userId,
      placeId: placeId,
      location: location,
      rating: rating,
      title: title,
      body: body,
      createdAt: createdAt,
    );
  }
}

extension ReviewEntityMapper on ReviewEntity {
  ReviewModel toModel() {
    return ReviewModel(
      id: id,
      userId: userId,
      placeId: placeId,
      location: location,
      rating: rating,
      title: title,
      body: body,
      createdAt: createdAt,
    );
  }
}
