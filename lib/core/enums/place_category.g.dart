// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaceCategoryAdapter extends TypeAdapter<PlaceCategory> {
  @override
  final typeId = 4;

  @override
  PlaceCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PlaceCategory.all;
      case 1:
        return PlaceCategory.hotel;
      case 2:
        return PlaceCategory.restaurant;
      case 3:
        return PlaceCategory.beach;
      case 4:
        return PlaceCategory.mountain;
      case 5:
        return PlaceCategory.desert;
      case 6:
        return PlaceCategory.diving;
      case 7:
        return PlaceCategory.trip;
      case 8:
        return PlaceCategory.activity;
      case 9:
        return PlaceCategory.park;
      case 10:
        return PlaceCategory.museum;
      case 11:
        return PlaceCategory.shopping;
      case 12:
        return PlaceCategory.entertainment;
      case 13:
        return PlaceCategory.heritage;
      case 14:
        return PlaceCategory.camping;
      case 15:
        return PlaceCategory.wellness;
      case 16:
        return PlaceCategory.cafe;
      case 17:
        return PlaceCategory.other;
      default:
        return PlaceCategory.all;
    }
  }

  @override
  void write(BinaryWriter writer, PlaceCategory obj) {
    switch (obj) {
      case PlaceCategory.all:
        writer.writeByte(0);
      case PlaceCategory.hotel:
        writer.writeByte(1);
      case PlaceCategory.restaurant:
        writer.writeByte(2);
      case PlaceCategory.beach:
        writer.writeByte(3);
      case PlaceCategory.mountain:
        writer.writeByte(4);
      case PlaceCategory.desert:
        writer.writeByte(5);
      case PlaceCategory.diving:
        writer.writeByte(6);
      case PlaceCategory.trip:
        writer.writeByte(7);
      case PlaceCategory.activity:
        writer.writeByte(8);
      case PlaceCategory.park:
        writer.writeByte(9);
      case PlaceCategory.museum:
        writer.writeByte(10);
      case PlaceCategory.shopping:
        writer.writeByte(11);
      case PlaceCategory.entertainment:
        writer.writeByte(12);
      case PlaceCategory.heritage:
        writer.writeByte(13);
      case PlaceCategory.camping:
        writer.writeByte(14);
      case PlaceCategory.wellness:
        writer.writeByte(15);
      case PlaceCategory.cafe:
        writer.writeByte(16);
      case PlaceCategory.other:
        writer.writeByte(17);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaceCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
