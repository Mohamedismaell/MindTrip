// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DayPlanModel _$DayPlanModelFromJson(Map<String, dynamic> json) =>
    _DayPlanModel(
      morning:
          (json['morning'] as List<dynamic>?)
              ?.map((e) => PlanPlaceModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PlanPlaceModel>[],
      afternoon:
          (json['afternoon'] as List<dynamic>?)
              ?.map((e) => PlanPlaceModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PlanPlaceModel>[],
      evening:
          (json['evening'] as List<dynamic>?)
              ?.map((e) => PlanPlaceModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PlanPlaceModel>[],
    );

Map<String, dynamic> _$DayPlanModelToJson(_DayPlanModel instance) =>
    <String, dynamic>{
      'morning': instance.morning,
      'afternoon': instance.afternoon,
      'evening': instance.evening,
    };
