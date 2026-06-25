// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_place_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlanPlaceModel _$PlanPlaceModelFromJson(Map<String, dynamic> json) =>
    _PlanPlaceModel(
      placeId: json['place_id'] == null ? '' : parseString(json['place_id']),
      name: json['name'] == null ? '' : parseString(json['name']),
      city: json['city'] == null ? '' : parseString(json['city']),
      cityEn: json['city_en'] == null ? '' : parseString(json['city_en']),
      interests: json['interests'] == null
          ? const []
          : parseStringList(json['interests']),
      category: json['category'] == null ? '' : parseString(json['category']),
      rating: json['rating'] == null ? 0.0 : parseDouble(json['rating']),
      reviewsCount: json['reviews_count'] == null
          ? 0
          : parseInt(json['reviews_count']),
      address: json['address'] == null ? '' : parseString(json['address']),
      description: json['description'] == null
          ? ''
          : parseString(json['description']),
      photoUrl: json['photo_url'] == null ? '' : parseString(json['photo_url']),
      imageUrls: json['image_urls'] == null
          ? const []
          : parseStringList(json['image_urls']),
      mapsUrl: json['maps_url'] == null ? '' : parseString(json['maps_url']),
      openingHours: json['opening_hours'] == null
          ? ''
          : parseString(json['opening_hours']),
      isOpened: json['is_opened'] == null
          ? false
          : parseBool(json['is_opened']),
      lat: json['lat'] == null ? 0.0 : parseDouble(json['lat']),
      lng: json['lng'] == null ? 0.0 : parseDouble(json['lng']),
      day: json['day'] == null ? 0 : parseDay(json['day']),
      type: json['type'] == null ? '' : parseString(json['type']),
      price: json['price'] == null ? 0 : parseInt(json['price']),
      cost: json['cost'] == null ? 0 : parseInt(json['cost']),
      isHiddenGem: json['is_hidden_gem'] == null
          ? false
          : parseBool(json['is_hidden_gem']),
    );

Map<String, dynamic> _$PlanPlaceModelToJson(_PlanPlaceModel instance) =>
    <String, dynamic>{
      'place_id': instance.placeId,
      'name': instance.name,
      'city': instance.city,
      'city_en': instance.cityEn,
      'interests': instance.interests,
      'category': instance.category,
      'rating': instance.rating,
      'reviews_count': instance.reviewsCount,
      'address': instance.address,
      'description': instance.description,
      'photo_url': instance.photoUrl,
      'image_urls': instance.imageUrls,
      'maps_url': instance.mapsUrl,
      'opening_hours': instance.openingHours,
      'is_opened': instance.isOpened,
      'lat': instance.lat,
      'lng': instance.lng,
      'day': instance.day,
      'type': instance.type,
      'price': instance.price,
      'cost': instance.cost,
      'is_hidden_gem': instance.isHiddenGem,
    };
