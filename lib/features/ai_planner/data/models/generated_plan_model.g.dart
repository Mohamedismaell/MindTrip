// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generated_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GeneratedPlanModel _$GeneratedPlanModelFromJson(Map<String, dynamic> json) =>
    _GeneratedPlanModel(
      tripId: json['trip_id'] == null ? '' : parseString(json['trip_id']),
      status: json['status'] == null ? '' : parseString(json['status']),
      people: json['people'] == null ? 0 : parseInt(json['people']),
      totalCalculatedCost: json['total_calculated_cost'] == null
          ? 0
          : parseInt(json['total_calculated_cost']),
      daysCount: json['days_count'] == null ? 0 : parseInt(json['days_count']),
      plan: json['plan'] == null
          ? null
          : PlanModel.fromJson(json['plan'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GeneratedPlanModelToJson(_GeneratedPlanModel instance) =>
    <String, dynamic>{
      'trip_id': instance.tripId,
      'status': instance.status,
      'people': instance.people,
      'total_calculated_cost': instance.totalCalculatedCost,
      'days_count': instance.daysCount,
      'plan': instance.plan,
    };
