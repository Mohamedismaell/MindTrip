// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => _ReviewModel(
  id: json['id'] as String? ?? '',
  userId: json['userId'] as String? ?? '',
  placeId: json['placeId'] as String? ?? '',
  location: json['location'] as String? ?? '',
  rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
  title: json['title'] as String? ?? '',
  body: json['body'] as String? ?? '',
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$ReviewModelToJson(_ReviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'placeId': instance.placeId,
      'location': instance.location,
      'rating': instance.rating,
      'title': instance.title,
      'body': instance.body,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
