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
          PlaceCategory.all,
    );

Map<String, dynamic> _$CategoryModelToJson(_CategoryModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'isSelected': instance.isSelected,
      'type': _$PlaceCategoryEnumMap[instance.type]!,
    };

const _$PlaceCategoryEnumMap = {
  PlaceCategory.all: 'all',
  PlaceCategory.food: 'food',
  PlaceCategory.cafes: 'cafes',
  PlaceCategory.historicalSites: 'historicalSites',
  PlaceCategory.religiousSites: 'religiousSites',
  PlaceCategory.beaches: 'beaches',
  PlaceCategory.nature: 'nature',
  PlaceCategory.entertainment: 'entertainment',
  PlaceCategory.shopping: 'shopping',
  PlaceCategory.artsCulture: 'artsCulture',
  PlaceCategory.hotels: 'hotels',
};
