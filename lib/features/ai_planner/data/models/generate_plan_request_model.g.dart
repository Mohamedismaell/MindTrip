// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_plan_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GeneratePlanRequestModel _$GeneratePlanRequestModelFromJson(
  Map<String, dynamic> json,
) => _GeneratePlanRequestModel(
  city: json['city'] as String,
  days: (json['days'] as num).toInt(),
  budget: (json['budget'] as num).toInt(),
  people: (json['people'] as num).toInt(),
  interests: (json['interests'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  mustInclude: json['mustInclude'] as String?,
);

Map<String, dynamic> _$GeneratePlanRequestModelToJson(
  _GeneratePlanRequestModel instance,
) => <String, dynamic>{
  'city': instance.city,
  'days': instance.days,
  'budget': instance.budget,
  'people': instance.people,
  'interests': instance.interests,
  'mustInclude': instance.mustInclude,
};
