// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_plan_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EditPlanResponseModel _$EditPlanResponseModelFromJson(
  Map<String, dynamic> json,
) => _EditPlanResponseModel(
  mode: json['mode'] as String,
  message: json['message'] as String?,
  tripId: json['trip_id'] as String?,
  status: json['status'] as String?,
  changeApplied: json['change_applied'] as String?,
  askForReplacement: json['ask_for_replacement'] as bool?,
  insertAfter: json['insert_after'] as String?,
  item: json['item'] == null
      ? null
      : PlanPlaceModel.fromJson(json['item'] as Map<String, dynamic>),
  people: (json['people'] as num?)?.toInt(),
  totalCalculatedCost: (json['total_calculated_cost'] as num?)?.toDouble(),
  daysCount: (json['days_count'] as num?)?.toInt(),
  needsReplan: json['needs_replan'] as bool?,
  plan: json['plan'] == null
      ? null
      : GeneratedPlanModel.fromJson(json['plan'] as Map<String, dynamic>),
);

Map<String, dynamic> _$EditPlanResponseModelToJson(
  _EditPlanResponseModel instance,
) => <String, dynamic>{
  'mode': instance.mode,
  'message': instance.message,
  'trip_id': instance.tripId,
  'status': instance.status,
  'change_applied': instance.changeApplied,
  'ask_for_replacement': instance.askForReplacement,
  'insert_after': instance.insertAfter,
  'item': instance.item,
  'people': instance.people,
  'total_calculated_cost': instance.totalCalculatedCost,
  'days_count': instance.daysCount,
  'needs_replan': instance.needsReplan,
  'plan': instance.plan,
};
