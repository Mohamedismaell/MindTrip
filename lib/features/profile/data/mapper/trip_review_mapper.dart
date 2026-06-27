import 'package:mindtrip/features/profile/data/models/trip_review_model.dart';
import 'package:mindtrip/features/profile/domain/entities/trip_review_entity.dart';

extension TripReviewModelMapper on TripReviewModel {
  TripReviewEntity toEntity() {
    return TripReviewEntity(
      tripReviewId: tripReviewId,
      tripId: tripId,
      destination: destination,
      rating: rating,
      comment: comment,
      createdAt: createdAt,
    );
  }
}

extension TripReviewEntityMapper on TripReviewEntity {
  TripReviewModel toModel() {
    return TripReviewModel(
      tripReviewId: tripReviewId,
      tripId: tripId,
      destination: destination,
      rating: rating,
      comment: comment,
      createdAt: createdAt,
    );
  }
}
