// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_collected_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatCollectedDataModel _$ChatCollectedDataModelFromJson(
  Map<String, dynamic> json,
) => _ChatCollectedDataModel(
  destination: json['destination'] == null
      ? ''
      : parseString(json['destination']),
  days: json['days'] == null ? 0 : parseInt(json['days']),
  budget: json['budget'] == null ? 0 : parseInt(json['budget']),
  interests: json['interests'] == null
      ? const []
      : parseStringList(json['interests']),
  people: json['people'] == null ? 0 : parseInt(json['people']),
  mustInclude:
      ChatCollectedDataModel._readMustInclude(json, 'mustInclude') == null
      ? const []
      : ChatCollectedDataModel._parseMustInclude(
          ChatCollectedDataModel._readMustInclude(json, 'mustInclude'),
        ),
);

Map<String, dynamic> _$ChatCollectedDataModelToJson(
  _ChatCollectedDataModel instance,
) => <String, dynamic>{
  'destination': instance.destination,
  'days': instance.days,
  'budget': instance.budget,
  'interests': instance.interests,
  'people': instance.people,
  'mustInclude': instance.mustInclude,
};
