// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatRequestModel _$ChatRequestModelFromJson(Map<String, dynamic> json) =>
    _ChatRequestModel(
      sessionId: json['sessionId'] as String,
      message: json['message'] as String,
      collected: CollectedDataModel.fromJson(
        json['collected'] as Map<String, dynamic>,
      ),
      cardAnswers: CollectedDataModel.fromJson(
        json['cardAnswers'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ChatRequestModelToJson(_ChatRequestModel instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'message': instance.message,
      'collected': instance.collected,
      'cardAnswers': instance.cardAnswers,
    };
