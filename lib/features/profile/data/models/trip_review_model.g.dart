// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TripReviewModel _$TripReviewModelFromJson(Map<String, dynamic> json) =>
    _TripReviewModel(
      tripReviewId: json['tripReviewId'] as String,
      tripId: json['tripId'] as String,
      destination: json['destination'] as String,
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$TripReviewModelToJson(_TripReviewModel instance) =>
    <String, dynamic>{
      'tripReviewId': instance.tripReviewId,
      'tripId': instance.tripId,
      'destination': instance.destination,
      'rating': instance.rating,
      'comment': instance.comment,
      'createdAt': instance.createdAt.toIso8601String(),
    };
