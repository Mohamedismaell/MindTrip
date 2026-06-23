// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_place_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FavoritePlaceModel _$FavoritePlaceModelFromJson(Map<String, dynamic> json) =>
    _FavoritePlaceModel(
      favoritePlaceId: json['favoritePlaceId'] as String,
      placeId: json['placeId'] as String,
      place: PlaceModel.fromJson(json['place'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FavoritePlaceModelToJson(_FavoritePlaceModel instance) =>
    <String, dynamic>{
      'favoritePlaceId': instance.favoritePlaceId,
      'placeId': instance.placeId,
      'place': instance.place,
    };
