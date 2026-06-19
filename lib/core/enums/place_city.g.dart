// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_city.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaceCityAdapter extends TypeAdapter<PlaceCity> {
  @override
  final typeId = 4;

  @override
  PlaceCity read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PlaceCity.cairo;
      case 1:
        return PlaceCity.giza;
      case 2:
        return PlaceCity.alexandria;
      case 3:
        return PlaceCity.ismailia;
      case 4:
        return PlaceCity.portSaid;
      case 5:
        return PlaceCity.luxor;
      case 6:
        return PlaceCity.aswan;
      case 7:
        return PlaceCity.hurghada;
      case 8:
        return PlaceCity.fayoum;
      case 9:
        return PlaceCity.sharmElSheikh;
      case 10:
        return PlaceCity.marsaMatrouh;
      default:
        return PlaceCity.cairo;
    }
  }

  @override
  void write(BinaryWriter writer, PlaceCity obj) {
    switch (obj) {
      case PlaceCity.cairo:
        writer.writeByte(0);
      case PlaceCity.giza:
        writer.writeByte(1);
      case PlaceCity.alexandria:
        writer.writeByte(2);
      case PlaceCity.ismailia:
        writer.writeByte(3);
      case PlaceCity.portSaid:
        writer.writeByte(4);
      case PlaceCity.luxor:
        writer.writeByte(5);
      case PlaceCity.aswan:
        writer.writeByte(6);
      case PlaceCity.hurghada:
        writer.writeByte(7);
      case PlaceCity.fayoum:
        writer.writeByte(8);
      case PlaceCity.sharmElSheikh:
        writer.writeByte(9);
      case PlaceCity.marsaMatrouh:
        writer.writeByte(10);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaceCityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
