// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DayPlanModel _$DayPlanModelFromJson(
  Map<String, dynamic> json,
) => _DayPlanModel(
  morning: json['morning'] == null ? const [] : _parsePlaces(json['morning']),
  afternoon: json['afternoon'] == null
      ? const []
      : _parsePlaces(json['afternoon']),
  evening: json['evening'] == null ? const [] : _parsePlaces(json['evening']),
);

Map<String, dynamic> _$DayPlanModelToJson(_DayPlanModel instance) =>
    <String, dynamic>{
      'morning': instance.morning,
      'afternoon': instance.afternoon,
      'evening': instance.evening,
    };
