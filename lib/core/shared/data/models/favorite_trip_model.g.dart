// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_trip_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteTripModelAdapter extends TypeAdapter<FavoriteTripModel> {
  @override
  final typeId = 15;

  @override
  FavoriteTripModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteTripModel(
      favoriteTripId: fields[0] as String,
      tripId: fields[1] as String,
      destination: fields[2] as String,
      startDate: fields[3] as DateTime,
      endDate: fields[4] as DateTime,
      durationDays: (fields[5] as num).toInt(),
      status: fields[6] as String,
      createdAt: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteTripModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.favoriteTripId)
      ..writeByte(1)
      ..write(obj.tripId)
      ..writeByte(2)
      ..write(obj.destination)
      ..writeByte(3)
      ..write(obj.startDate)
      ..writeByte(4)
      ..write(obj.endDate)
      ..writeByte(5)
      ..write(obj.durationDays)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteTripModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FavoriteTripModel _$FavoriteTripModelFromJson(Map<String, dynamic> json) =>
    _FavoriteTripModel(
      favoriteTripId: json['favoriteTripId'] as String,
      tripId: json['tripId'] as String,
      destination: json['destination'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      durationDays: (json['durationDays'] as num).toInt(),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$FavoriteTripModelToJson(_FavoriteTripModel instance) =>
    <String, dynamic>{
      'favoriteTripId': instance.favoriteTripId,
      'tripId': instance.tripId,
      'destination': instance.destination,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'durationDays': instance.durationDays,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
    };
