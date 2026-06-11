// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TripModelAdapter extends TypeAdapter<TripModel> {
  @override
  final typeId = 5;

  @override
  TripModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TripModel(
      id: fields[0] as String,
      title: fields[1] as String,
      status: fields[2] as String,
      createdAt: fields[3] as DateTime,
      updatedAt: fields[4] as DateTime,
      destination: fields[5] as String,
      tripStart: fields[6] as DateTime?,
      tripEnd: fields[7] as DateTime?,
      adults: (fields[8] as num).toInt(),
      children: (fields[9] as num).toInt(),
      budgetTier: fields[10] as String?,
      customBudget: fields[11] as String,
      interests: (fields[12] as List).cast<String>(),
      itineraryCoverUrl: fields[13] as String?,
      placePreviewsJson: fields[16] == null ? '[]' : fields[16] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TripModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.updatedAt)
      ..writeByte(5)
      ..write(obj.destination)
      ..writeByte(6)
      ..write(obj.tripStart)
      ..writeByte(7)
      ..write(obj.tripEnd)
      ..writeByte(8)
      ..write(obj.adults)
      ..writeByte(9)
      ..write(obj.children)
      ..writeByte(10)
      ..write(obj.budgetTier)
      ..writeByte(11)
      ..write(obj.customBudget)
      ..writeByte(12)
      ..write(obj.interests)
      ..writeByte(13)
      ..write(obj.itineraryCoverUrl)
      ..writeByte(16)
      ..write(obj.placePreviewsJson);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TripModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
