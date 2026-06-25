// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_trip_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateTripRequestModel _$CreateTripRequestModelFromJson(
  Map<String, dynamic> json,
) => _CreateTripRequestModel(
  title: json['title'] as String,
  destinationGovernorate: json['destinationGovernorate'] as String,
  city: json['city'] as String,
  startDate: json['startDate'] as String?,
  endDate: json['endDate'] as String?,
  people: (json['people'] as num).toInt(),
  totalBudgetEgp: (json['totalBudgetEgp'] as num).toInt(),
  totalCost: (json['totalCost'] as num).toInt(),
  plan: json['plan'] as Map<String, dynamic>,
  collected: json['collected'] as String,
  sessionId: json['sessionId'] as String?,
  isPublic: json['isPublic'] as bool,
  status: (json['status'] as num).toInt(),
);

Map<String, dynamic> _$CreateTripRequestModelToJson(
  _CreateTripRequestModel instance,
) => <String, dynamic>{
  'title': instance.title,
  'destinationGovernorate': instance.destinationGovernorate,
  'city': instance.city,
  'startDate': instance.startDate,
  'endDate': instance.endDate,
  'people': instance.people,
  'totalBudgetEgp': instance.totalBudgetEgp,
  'totalCost': instance.totalCost,
  'plan': instance.plan,
  'collected': instance.collected,
  'sessionId': instance.sessionId,
  'isPublic': instance.isPublic,
  'status': instance.status,
};
