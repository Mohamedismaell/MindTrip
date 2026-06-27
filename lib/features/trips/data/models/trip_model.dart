import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/ai_planner/data/models/collected_planner_data_model.dart';
import 'package:mindtrip/features/ai_planner/data/models/generated_plan_model.dart';

class TripModel extends Equatable {
  const TripModel({
    required this.tripId,
    required this.title,
    required this.destinationGovernorate,
    required this.city,
    required this.startDate,
    required this.endDate,
    required this.durationDays,
    required this.people,
    required this.totalBudgetEgp,
    required this.totalCost,
    required this.status,
    this.shareToken,
    required this.isPublic,
    this.sessionId,
    this.collected,
    this.coverImageUrl,
    required this.placesCount,
    required this.progressPercent,
    required this.createdAt,
    required this.updatedAt,
    required this.plan,
  });

  final String tripId;
  final String title;
  final String destinationGovernorate;
  final String city;
  final DateTime startDate;
  final DateTime endDate;
  final int durationDays;
  final int people;
  final int totalBudgetEgp;
  final int totalCost;
  final String status;
  final String? shareToken;
  final bool isPublic;
  final String? sessionId;
  final CollectedDataModel? collected;
  final String? coverImageUrl;
  final int placesCount;
  final int progressPercent;
  final DateTime createdAt;
  final DateTime updatedAt;
  final GeneratedPlanModel plan;

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      tripId: json['tripId'] as String? ?? '',
      title: json['title'] as String? ?? 'Untitled Trip',
      destinationGovernorate: json['destinationGovernorate'] as String? ?? '',
      city: json['city'] as String? ?? '',
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'] as String)
          : DateTime.now(),
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate'] as String)
          : DateTime.now(),
      durationDays: (json['durationDays'] as num?)?.toInt() ?? 0,
      people: (json['people'] as num?)?.toInt() ?? 1,
      totalBudgetEgp: (json['totalBudgetEgp'] as num?)?.toInt() ?? 0,
      totalCost: (json['totalCost'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? 'Draft',
      shareToken: json['shareToken'] as String?,
      isPublic: json['isPublic'] as bool? ?? false,
      sessionId: json['sessionId'] as String?,
      collected: _collectedFromJson(json['collectedJson']),
      coverImageUrl: json['coverImageUrl'] as String?,
      placesCount: (json['placesCount'] as num?)?.toInt() ?? 0,
      progressPercent: (json['progressPercent'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now(),
      plan: json['plan'] != null
          ? GeneratedPlanModel.fromJson(json['plan'] as Map<String, dynamic>)
          : GeneratedPlanModel.empty(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tripId': tripId,
      'title': title,
      'destinationGovernorate': destinationGovernorate,
      'city': city,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'durationDays': durationDays,
      'people': people,
      'totalBudgetEgp': totalBudgetEgp,
      'totalCost': totalCost,
      'status': status,
      'shareToken': shareToken,
      'isPublic': isPublic,
      'sessionId': sessionId,
      'collectedJson': collected != null ? _collectedToJson(collected!) : null,
      'coverImageUrl': coverImageUrl,
      'placesCount': placesCount,
      'progressPercent': progressPercent,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'plan': plan.toJson(),
    };
  }

  TripModel copyWith({
    String? tripId,
    String? title,
    String? destinationGovernorate,
    String? city,
    DateTime? startDate,
    DateTime? endDate,
    int? durationDays,
    int? people,
    int? totalBudgetEgp,
    int? totalCost,
    String? status,
    String? shareToken,
    bool? isPublic,
    String? sessionId,
    CollectedDataModel? collected,
    String? coverImageUrl,
    int? placesCount,
    int? progressPercent,
    DateTime? createdAt,
    DateTime? updatedAt,
    GeneratedPlanModel? plan,
  }) {
    return TripModel(
      tripId: tripId ?? this.tripId,
      title: title ?? this.title,
      destinationGovernorate:
          destinationGovernorate ?? this.destinationGovernorate,
      city: city ?? this.city,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      durationDays: durationDays ?? this.durationDays,
      people: people ?? this.people,
      totalBudgetEgp: totalBudgetEgp ?? this.totalBudgetEgp,
      totalCost: totalCost ?? this.totalCost,
      status: status ?? this.status,
      shareToken: shareToken ?? this.shareToken,
      isPublic: isPublic ?? this.isPublic,
      sessionId: sessionId ?? this.sessionId,
      collected: collected ?? this.collected,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      placesCount: placesCount ?? this.placesCount,
      progressPercent: progressPercent ?? this.progressPercent,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      plan: plan ?? this.plan,
    );
  }

  static CollectedDataModel? _collectedFromJson(dynamic json) {
    if (json == null) return null;

    if (json is String) {
      if (json.isEmpty) return null;

      return CollectedDataModel.fromJson(
        jsonDecode(json) as Map<String, dynamic>,
      );
    }

    if (json is Map<String, dynamic>) {
      return CollectedDataModel.fromJson(json);
    }

    return null;
  }

  static String _collectedToJson(CollectedDataModel model) {
    return jsonEncode(model.toJson());
  }

  @override
  List<Object?> get props => [
    tripId,
    title,
    destinationGovernorate,
    city,
    startDate,
    endDate,
    durationDays,
    people,
    totalBudgetEgp,
    totalCost,
    status,
    shareToken,
    isPublic,
    sessionId,
    collected,
    coverImageUrl,
    placesCount,
    progressPercent,
    createdAt,
    updatedAt,
    plan,
  ];
}
