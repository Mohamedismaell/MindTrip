// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_plan_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GeneratePlanMustIncludeItem _$GeneratePlanMustIncludeItemFromJson(
  Map<String, dynamic> json,
) => _GeneratePlanMustIncludeItem(
  name: json['name'] as String,
  placeId: json['place_id'] as String?,
  type: json['type'] as String?,
);

Map<String, dynamic> _$GeneratePlanMustIncludeItemToJson(
  _GeneratePlanMustIncludeItem instance,
) => <String, dynamic>{
  'name': instance.name,
  'place_id': ?instance.placeId,
  'type': ?instance.type,
};

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
  mustInclude:
      (json['must_include'] as List<dynamic>?)
          ?.map(
            (e) =>
                GeneratePlanMustIncludeItem.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$GeneratePlanRequestModelToJson(
  _GeneratePlanRequestModel instance,
) => <String, dynamic>{
  'city': instance.city,
  'days': instance.days,
  'budget': instance.budget,
  'people': instance.people,
  'interests': instance.interests,
  'must_include': instance.mustInclude.map((e) => e.toJson()).toList(),
};
