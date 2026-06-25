// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planner_preview_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlannerStopModelAdapter extends TypeAdapter<PlannerStopModel> {
  @override
  final typeId = 12;

  @override
  PlannerStopModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlannerStopModel(
      time: fields[0] as String,
      label: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PlannerStopModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.time)
      ..writeByte(1)
      ..write(obj.label);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlannerStopModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PlannerPreviewModelAdapter extends TypeAdapter<PlannerPreviewModel> {
  @override
  final typeId = 13;

  @override
  PlannerPreviewModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlannerPreviewModel(
      title: fields[0] as String,
      imageUrl: fields[1] as String,
      stops: (fields[2] as List).cast<PlannerStopModel>(),
      badge: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PlannerPreviewModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.imageUrl)
      ..writeByte(2)
      ..write(obj.stops)
      ..writeByte(3)
      ..write(obj.badge);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlannerPreviewModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlannerStopModel _$PlannerStopModelFromJson(Map<String, dynamic> json) =>
    _PlannerStopModel(
      time: json['time'] as String,
      label: json['label'] as String,
    );

Map<String, dynamic> _$PlannerStopModelToJson(_PlannerStopModel instance) =>
    <String, dynamic>{'time': instance.time, 'label': instance.label};

_PlannerPreviewModel _$PlannerPreviewModelFromJson(Map<String, dynamic> json) =>
    _PlannerPreviewModel(
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      stops: (json['stops'] as List<dynamic>)
          .map((e) => PlannerStopModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      badge: json['badge'] as String,
    );

Map<String, dynamic> _$PlannerPreviewModelToJson(
  _PlannerPreviewModel instance,
) => <String, dynamic>{
  'title': instance.title,
  'imageUrl': instance.imageUrl,
  'stops': instance.stops,
  'badge': instance.badge,
};
