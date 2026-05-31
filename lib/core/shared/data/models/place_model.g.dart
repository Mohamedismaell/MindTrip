// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaceModelAdapter extends TypeAdapter<_PlaceModel> {
  @override
  final typeId = 1;

  @override
  _PlaceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _PlaceModel(
      id: fields[0] == null ? '' : fields[0] as String,
      name: fields[1] == null ? '' : fields[1] as String,
      description: fields[2] as String?,
      location: fields[3] as LocationModel,
      coverImage: (fields[4] as List?)?.cast<String>(),
      imageUrls: (fields[5] as List?)?.cast<String>(),
      category: fields[6] == null
          ? PlaceCategory.other
          : fields[6] as PlaceCategory,
      rating: (fields[7] as num?)?.toDouble(),
      reviewCount: (fields[8] as num?)?.toInt(),
      price: (fields[9] as num?)?.toDouble(),
      isFavorite: fields[10] == null ? false : fields[10] as bool,
      badge: fields[11] == null ? PlaceBadge.none : fields[11] as PlaceBadge,
    );
  }

  @override
  void write(BinaryWriter writer, _PlaceModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.location)
      ..writeByte(4)
      ..write(obj.coverImage)
      ..writeByte(5)
      ..write(obj.imageUrls)
      ..writeByte(6)
      ..write(obj.category)
      ..writeByte(7)
      ..write(obj.rating)
      ..writeByte(8)
      ..write(obj.reviewCount)
      ..writeByte(9)
      ..write(obj.price)
      ..writeByte(10)
      ..write(obj.isFavorite)
      ..writeByte(11)
      ..write(obj.badge);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlaceModel _$PlaceModelFromJson(Map<String, dynamic> json) => _PlaceModel(
  id: json['id'] as String? ?? '',
  name: json['name'] as String? ?? '',
  description: json['description'] as String?,
  location: LocationModel.fromJson(json['location'] as Map<String, dynamic>),
  coverImage: (json['coverImage'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  imageUrls: (json['imageUrls'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  category:
      $enumDecodeNullable(_$PlaceCategoryEnumMap, json['category']) ??
      PlaceCategory.other,
  rating: (json['rating'] as num?)?.toDouble(),
  reviewCount: (json['reviewCount'] as num?)?.toInt(),
  price: (json['price'] as num?)?.toDouble(),
  isFavorite: json['isFavorite'] as bool? ?? false,
  badge:
      $enumDecodeNullable(_$PlaceBadgeEnumMap, json['badge']) ??
      PlaceBadge.none,
);

Map<String, dynamic> _$PlaceModelToJson(_PlaceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
      'coverImage': instance.coverImage,
      'imageUrls': instance.imageUrls,
      'category': _$PlaceCategoryEnumMap[instance.category]!,
      'rating': instance.rating,
      'reviewCount': instance.reviewCount,
      'price': instance.price,
      'isFavorite': instance.isFavorite,
      'badge': _$PlaceBadgeEnumMap[instance.badge]!,
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

const _$PlaceBadgeEnumMap = {
  PlaceBadge.topRated: 'topRated',
  PlaceBadge.popular: 'popular',
  PlaceBadge.trending: 'trending',
  PlaceBadge.aiCrafted: 'aiCrafted',
  PlaceBadge.none: 'none',
};
