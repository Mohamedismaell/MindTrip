// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TripModel _$TripModelFromJson(Map<String, dynamic> json) => _TripModel(
  id: json['id'] as String? ?? '',
  title: json['title'] as String? ?? '',
  subtitle: json['subtitle'] as String? ?? '',
  imageUrl: json['imageUrl'] as String? ?? '',
  places:
      (json['places'] as List<dynamic>?)
          ?.map((e) => PlaceModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  startDate: json['startDate'] == null
      ? null
      : DateTime.parse(json['startDate'] as String),
  endDate: json['endDate'] == null
      ? null
      : DateTime.parse(json['endDate'] as String),
  isFavorite: json['isFavorite'] as bool? ?? false,
  isAiGenerated: json['isAiGenerated'] as bool? ?? false,
);

Map<String, dynamic> _$TripModelToJson(_TripModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'imageUrl': instance.imageUrl,
      'places': instance.places,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'isFavorite': instance.isFavorite,
      'isAiGenerated': instance.isAiGenerated,
    };
