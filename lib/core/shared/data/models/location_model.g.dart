// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocationModelAdapter extends TypeAdapter<_LocationModel> {
  @override
  final typeId = 2;

  @override
  _LocationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _LocationModel(
      address: fields[0] == null ? '' : fields[0] as String,
      latitude: fields[1] == null ? 0.0 : (fields[1] as num).toDouble(),
      longitude: fields[2] == null ? 0.0 : (fields[2] as num).toDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, _LocationModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.address)
      ..writeByte(1)
      ..write(obj.latitude)
      ..writeByte(2)
      ..write(obj.longitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LocationModel _$LocationModelFromJson(Map<String, dynamic> json) =>
    _LocationModel(
      address: json['location'] as String? ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$LocationModelToJson(_LocationModel instance) =>
    <String, dynamic>{
      'location': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
