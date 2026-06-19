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
        return PlaceCategory.food;
      case 2:
        return PlaceCategory.cafes;
      case 3:
        return PlaceCategory.historicalSites;
      case 4:
        return PlaceCategory.religiousSites;
      case 5:
        return PlaceCategory.beaches;
      case 6:
        return PlaceCategory.nature;
      case 7:
        return PlaceCategory.entertainment;
      case 8:
        return PlaceCategory.shopping;
      case 9:
        return PlaceCategory.artsCulture;
      case 10:
        return PlaceCategory.hotels;
      default:
        return PlaceCategory.all;
    }
  }

  @override
  void write(BinaryWriter writer, PlaceCategory obj) {
    switch (obj) {
      case PlaceCategory.all:
        writer.writeByte(0);
      case PlaceCategory.food:
        writer.writeByte(1);
      case PlaceCategory.cafes:
        writer.writeByte(2);
      case PlaceCategory.historicalSites:
        writer.writeByte(3);
      case PlaceCategory.religiousSites:
        writer.writeByte(4);
      case PlaceCategory.beaches:
        writer.writeByte(5);
      case PlaceCategory.nature:
        writer.writeByte(6);
      case PlaceCategory.entertainment:
        writer.writeByte(7);
      case PlaceCategory.shopping:
        writer.writeByte(8);
      case PlaceCategory.artsCulture:
        writer.writeByte(9);
      case PlaceCategory.hotels:
        writer.writeByte(10);
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
