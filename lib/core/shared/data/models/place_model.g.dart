// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaceModelAdapter extends TypeAdapter<PlaceModel> {
  @override
  final typeId = 6;

  @override
  PlaceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlaceModel(
      placeId: fields[0] as String,
      name: fields[1] as String,
      city: fields[2] as String?,
      cityEn: fields[3] as String?,
      interests: (fields[4] as List?)?.cast<String>(),
      category: fields[5] as String?,
      price: (fields[6] as num?)?.toDouble(),
      cost: (fields[7] as num?)?.toDouble(),
      rating: (fields[8] as num?)?.toDouble(),
      reviewsCount: (fields[9] as num?)?.toInt(),
      address: fields[10] as String?,
      description: fields[11] as String?,
      photoUrl: fields[12] as String?,
      imageUrls: (fields[13] as List?)?.cast<String>(),
      openingHours: fields[14] as String?,
      lat: fields[15] == null ? 0.0 : (fields[15] as num).toDouble(),
      lng: fields[16] == null ? 0.0 : (fields[16] as num).toDouble(),
      isHiddenGem: fields[17] == null ? false : fields[17] as bool,
      mapsUrl: fields[18] as String?,
      day: fields[19] as String?,
      isOpened: fields[20] as String?,
      type: fields[21] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PlaceModel obj) {
    writer
      ..writeByte(22)
      ..writeByte(0)
      ..write(obj.placeId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.city)
      ..writeByte(3)
      ..write(obj.cityEn)
      ..writeByte(4)
      ..write(obj.interests)
      ..writeByte(5)
      ..write(obj.category)
      ..writeByte(6)
      ..write(obj.price)
      ..writeByte(7)
      ..write(obj.cost)
      ..writeByte(8)
      ..write(obj.rating)
      ..writeByte(9)
      ..write(obj.reviewsCount)
      ..writeByte(10)
      ..write(obj.address)
      ..writeByte(11)
      ..write(obj.description)
      ..writeByte(12)
      ..write(obj.photoUrl)
      ..writeByte(13)
      ..write(obj.imageUrls)
      ..writeByte(14)
      ..write(obj.openingHours)
      ..writeByte(15)
      ..write(obj.lat)
      ..writeByte(16)
      ..write(obj.lng)
      ..writeByte(17)
      ..write(obj.isHiddenGem)
      ..writeByte(18)
      ..write(obj.mapsUrl)
      ..writeByte(19)
      ..write(obj.day)
      ..writeByte(20)
      ..write(obj.isOpened)
      ..writeByte(21)
      ..write(obj.type);
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
  placeId: json['place_id'] as String,
  name: json['name'] as String,
  city: json['city'] as String?,
  cityEn: json['city_en'] as String?,
  interests: _toListOfStrings(json['interests']),
  category: json['category'] as String?,
  price: _toDouble(json['price']),
  cost: _toDouble(json['cost']),
  rating: _toDouble(json['rating']),
  reviewsCount: (json['reviews_count'] as num?)?.toInt(),
  address: json['address'] as String?,
  description: json['description'] as String?,
  photoUrl: json['photo_url'] as String?,
  imageUrls: _toListOfStrings(json['image_urls']),
  openingHours: json['opening_hours'] as String?,
  lat: json['lat'] == null ? 0.0 : _toDoubleNonNullable(json['lat']),
  lng: json['lng'] == null ? 0.0 : _toDoubleNonNullable(json['lng']),
  isHiddenGem: json['is_hidden_gem'] as bool? ?? false,
  mapsUrl: json['maps_url'] as String?,
  day: _toString(json['day']),
  isOpened: _toString(json['is_opened']),
  type: _toString(json['type']),
);

Map<String, dynamic> _$PlaceModelToJson(_PlaceModel instance) =>
    <String, dynamic>{
      'place_id': instance.placeId,
      'name': instance.name,
      'city': instance.city,
      'city_en': instance.cityEn,
      'interests': instance.interests,
      'category': instance.category,
      'price': instance.price,
      'cost': instance.cost,
      'rating': instance.rating,
      'reviews_count': instance.reviewsCount,
      'address': instance.address,
      'description': instance.description,
      'photo_url': instance.photoUrl,
      'image_urls': instance.imageUrls,
      'opening_hours': instance.openingHours,
      'lat': instance.lat,
      'lng': instance.lng,
      'is_hidden_gem': instance.isHiddenGem,
      'maps_url': instance.mapsUrl,
      'day': instance.day,
      'is_opened': instance.isOpened,
      'type': instance.type,
    };
