// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TripModel _$TripModelFromJson(Map<String, dynamic> json) => _TripModel(
  tripId: json['tripId'] as String,
  title: json['title'] as String,
  destinationGovernorate: json['destinationGovernorate'] as String,
  city: json['city'] as String,
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
  durationDays: (json['durationDays'] as num).toInt(),
  people: (json['people'] as num).toInt(),
  totalBudgetEgp: (json['totalBudgetEgp'] as num).toInt(),
  totalCost: (json['totalCost'] as num).toInt(),
  status: json['status'] as String,
  shareToken: json['shareToken'] as String,
  isPublic: json['isPublic'] as bool,
  sessionId: json['sessionId'] as String,
  collected: TripModel._collectedFromJson(json['collectedJson']),
  coverImageUrl: json['coverImageUrl'] as String,
  placesCount: (json['placesCount'] as num).toInt(),
  progressPercent: (json['progressPercent'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  plan: GeneratedPlanModel.fromJson(json['plan'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TripModelToJson(_TripModel instance) =>
    <String, dynamic>{
      'tripId': instance.tripId,
      'title': instance.title,
      'destinationGovernorate': instance.destinationGovernorate,
      'city': instance.city,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'durationDays': instance.durationDays,
      'people': instance.people,
      'totalBudgetEgp': instance.totalBudgetEgp,
      'totalCost': instance.totalCost,
      'status': instance.status,
      'shareToken': instance.shareToken,
      'isPublic': instance.isPublic,
      'sessionId': instance.sessionId,
      'collectedJson': TripModel._collectedToJson(instance.collected),
      'coverImageUrl': instance.coverImageUrl,
      'placesCount': instance.placesCount,
      'progressPercent': instance.progressPercent,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'plan': instance.plan,
    };
