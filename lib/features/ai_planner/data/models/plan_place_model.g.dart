// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_place_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlanPlaceModel _$PlanPlaceModelFromJson(Map<String, dynamic> json) =>
    _PlanPlaceModel(
      placeId: json['place_id'] as String,
      name: json['name'] as String,
      city: json['city'] as String,
      cityEn: json['city_en'] as String,
      category: json['category'] as String,
      rating: parseDouble(json['rating']),
      reviewsCount: parseInt(json['reviews_count']),
      address: json['address'] as String,
      description: json['description'] as String,
      photoUrl: json['photo_url'] as String,
      imageUrls: parseStringList(json['image_urls']),
      mapsUrl: json['maps_url'] as String,
      lat: parseDouble(json['lat']),
      lng: parseDouble(json['lng']),
      day: parseDay(json['day']),
      type: json['type'] as String,
      price: parseDouble(json['price']),
      cost: parseDouble(json['cost']),
      interests: parseStringList(json['interests']),
      isHiddenGem: json['is_hidden_gem'] as bool,
      openingHours: json['opening_hours'] as String,
      isOpened: parseBool(json['is_opened']),
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
