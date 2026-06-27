// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_plan_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EditPlanRequestModel _$EditPlanRequestModelFromJson(
  Map<String, dynamic> json,
) => _EditPlanRequestModel(
  targetChange: json['targetChange'] as String,
  destination: json['destination'] as String,
  city: json['city'] as String,
  days: (json['days'] as num).toInt(),
  budget: (json['budget'] as num).toInt(),
  people: (json['people'] as num).toInt(),
  interests: (json['interests'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  existingPlan: (json['existingPlan'] as List<dynamic>)
      .map((e) => PlanPlaceModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  places:
      (json['places'] as List<dynamic>?)
          ?.map((e) => PlanPlaceModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  conversation:
      (json['conversation'] as List<dynamic>?)
          ?.map(
            (e) => ConversationTurnModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  tripId: json['tripId'] as String?,
  mustInclude: (json['mustInclude'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  mode: json['mode'] as String?,
  item: json['item'] == null
      ? null
      : ItemToEdit.fromJson(json['item'] as Map<String, dynamic>),
);

Map<String, dynamic> _$EditPlanRequestModelToJson(
  _EditPlanRequestModel instance,
) => <String, dynamic>{
  'targetChange': instance.targetChange,
  'destination': instance.destination,
  'city': instance.city,
  'days': instance.days,
  'budget': instance.budget,
  'people': instance.people,
  'interests': instance.interests,
  'existingPlan': instance.existingPlan,
  'places': instance.places,
  'conversation': instance.conversation,
  'tripId': instance.tripId,
  'mustInclude': instance.mustInclude,
  'mode': instance.mode,
  'item': instance.item,
};

_ItemToEdit _$ItemToEditFromJson(Map<String, dynamic> json) => _ItemToEdit(
  placeId: json['place_id'] as String?,
  name: json['name'] as String?,
);

Map<String, dynamic> _$ItemToEditToJson(_ItemToEdit instance) =>
    <String, dynamic>{'place_id': instance.placeId, 'name': instance.name};

_ConversationTurnModel _$ConversationTurnModelFromJson(
  Map<String, dynamic> json,
) => _ConversationTurnModel(
  role: json['role'] as String,
  content: json['content'] as String,
);

Map<String, dynamic> _$ConversationTurnModelToJson(
  _ConversationTurnModel instance,
) => <String, dynamic>{'role': instance.role, 'content': instance.content};
