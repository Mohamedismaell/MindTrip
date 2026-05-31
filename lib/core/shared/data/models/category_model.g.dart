// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    _CategoryModel(
      name: json['name'] as String? ?? '',
      isSelected: json['isSelected'] as bool? ?? false,
      type:
          $enumDecodeNullable(_$PlaceCategoryEnumMap, json['type']) ??
          PlaceCategory.other,
    );

Map<String, dynamic> _$CategoryModelToJson(_CategoryModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'isSelected': instance.isSelected,
      'type': _$PlaceCategoryEnumMap[instance.type]!,
    };

const _$PlaceCategoryEnumMap = {
  PlaceCategory.all: 'all',
  PlaceCategory.hotel: 'hotel',
  PlaceCategory.restaurant: 'restaurant',
  PlaceCategory.beach: 'beach',
  PlaceCategory.mountain: 'mountain',
  PlaceCategory.desert: 'desert',
  PlaceCategory.diving: 'diving',
  PlaceCategory.trip: 'trip',
  PlaceCategory.activity: 'activity',
  PlaceCategory.park: 'park',
  PlaceCategory.museum: 'museum',
  PlaceCategory.shopping: 'shopping',
  PlaceCategory.entertainment: 'entertainment',
  PlaceCategory.heritage: 'heritage',
  PlaceCategory.camping: 'camping',
  PlaceCategory.wellness: 'wellness',
  PlaceCategory.cafe: 'cafe',
  PlaceCategory.other: 'other',
};
