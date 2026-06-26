// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collected_planner_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CollectedDataModel _$CollectedDataModelFromJson(Map<String, dynamic> json) =>
    _CollectedDataModel(
      destination: json['destination'] == null
          ? ''
          : parseString(json['destination']),
      days: json['days'] == null ? 0 : parseInt(json['days']),
      budget: json['budget'] == null ? 0 : parseInt(json['budget']),
      interests: json['interests'] == null
          ? const <String>[]
          : parseStringList(json['interests']),
      people: json['people'] == null ? 0 : parseInt(json['people']),
      mustInclude: json['mustInclude'] == null
          ? const <String>[]
          : parseStringList(json['mustInclude']),
    );

Map<String, dynamic> _$CollectedDataModelToJson(_CollectedDataModel instance) =>
    <String, dynamic>{
      'destination': instance.destination,
      'days': instance.days,
      'budget': instance.budget,
      'interests': instance.interests,
      'people': instance.people,
      'mustInclude': instance.mustInclude,
    };
