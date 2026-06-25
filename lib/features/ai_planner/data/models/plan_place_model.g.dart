// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_place_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlanPlaceModel _$PlanPlaceModelFromJson(
  Map<String, dynamic> json,
) => _PlanPlaceModel(
  placeId: json['place_id'] as String? ?? '',
  name: json['name'] as String? ?? '',
  city: json['city'] as String? ?? '',
  cityEn: json['city_en'] as String? ?? '',
  category: json['category'] as String? ?? '',
  rating: json['rating'] == null ? 0 : parseDouble(json['rating']),
  reviewsCount: json['reviews_count'] == null
      ? 0
      : parseInt(json['reviews_count']),
  address: json['address'] as String? ?? '',
  description: json['description'] as String? ?? '',
  photoUrl: json['photo_url'] as String? ?? '',
  imageUrls:
      (json['image_urls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  mapsUrl: json['maps_url'] as String? ?? '',
  lat: json['lat'] == null ? 0 : parseDouble(json['lat']),
  lng: json['lng'] == null ? 0 : parseDouble(json['lng']),
  day: json['day'] == null ? 0 : parseInt(json['day']),
  type: json['type'] as String? ?? '',
  price: json['price'] == null ? 0 : parseDouble(json['price']),
  cost: json['cost'] == null ? 0 : parseDouble(json['cost']),
  interests:
      (json['interests'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  isHiddenGem: json['is_hidden_gem'] as bool? ?? false,
  openingHours: json['opening_hours'] as String? ?? '',
  isOpened: json['is_opened'] == null ? false : parseBool(json['is_opened']),
);

Map<String, dynamic> _$PlanPlaceModelToJson(_PlanPlaceModel instance) =>
    <String, dynamic>{
      'place_id': instance.placeId,
      'name': instance.name,
      'city': instance.city,
      'city_en': instance.cityEn,
      'category': instance.category,
      'rating': instance.rating,
      'reviews_count': instance.reviewsCount,
      'address': instance.address,
      'description': instance.description,
      'photo_url': instance.photoUrl,
      'image_urls': instance.imageUrls,
      'maps_url': instance.mapsUrl,
      'lat': instance.lat,
      'lng': instance.lng,
      'day': instance.day,
      'type': instance.type,
      'price': instance.price,
      'cost': instance.cost,
      'interests': instance.interests,
      'is_hidden_gem': instance.isHiddenGem,
      'opening_hours': instance.openingHours,
      'is_opened': instance.isOpened,
    };
