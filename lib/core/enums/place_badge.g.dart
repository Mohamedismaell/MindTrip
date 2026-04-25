// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_badge.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaceBadgeAdapter extends TypeAdapter<PlaceBadge> {
  @override
  final typeId = 3;

  @override
  PlaceBadge read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PlaceBadge.topRated;
      case 1:
        return PlaceBadge.popular;
      case 2:
        return PlaceBadge.trending;
      case 3:
        return PlaceBadge.aiCrafted;
      case 4:
        return PlaceBadge.none;
      default:
        return PlaceBadge.topRated;
    }
  }

  @override
  void write(BinaryWriter writer, PlaceBadge obj) {
    switch (obj) {
      case PlaceBadge.topRated:
        writer.writeByte(0);
      case PlaceBadge.popular:
        writer.writeByte(1);
      case PlaceBadge.trending:
        writer.writeByte(2);
      case PlaceBadge.aiCrafted:
        writer.writeByte(3);
      case PlaceBadge.none:
        writer.writeByte(4);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaceBadgeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
