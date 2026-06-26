// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatResponseModel _$ChatResponseModelFromJson(Map<String, dynamic> json) =>
    _ChatResponseModel(
      status: json['status'] == null ? '' : parseString(json['status']),
      output: json['output'] == null ? '' : parseString(json['output']),
      collected: json['collected'] == null
          ? const ChatCollectedDataModel()
          : ChatCollectedDataModel.fromJson(
              json['collected'] as Map<String, dynamic>,
            ),
      missing: json['missing'] == null
          ? const []
          : parseStringList(json['missing']),
    );

Map<String, dynamic> _$ChatResponseModelToJson(_ChatResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'output': instance.output,
      'collected': instance.collected,
      'missing': instance.missing,
    };
