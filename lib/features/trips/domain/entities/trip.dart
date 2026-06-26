import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/collected_planner_data_entity.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/generated_plan_entity.dart';

enum TripStatus { draft, inProgress, completed, upcoming, cancelled }

class Trip extends Equatable {
  const Trip({
    required this.tripId,
    required this.title,
    required this.city,
    required this.destinationGovernorate,
    required this.tripStart,
    required this.tripEnd,
    required this.durationDays,
    required this.people,
    required this.totalBudget,
    required this.totalCost,
    required this.status,
    required this.shareToken,
    required this.isPublic,
    required this.sessionId,
    required this.coverImageUrl,
    required this.placesCount,
    required this.progressPercent,
    required this.plan,
    this.collected,
    required this.createdAt,
    required this.updatedAt,
  });

  final String tripId;

  final String title;

  final String city;

  final String destinationGovernorate;

  final DateTime tripStart;

  final DateTime tripEnd;

  final int durationDays;

  final int people;

  final int totalBudget;

  final int totalCost;

  final TripStatus status;

  final String shareToken;

  final bool isPublic;

  final String sessionId;

  final String? coverImageUrl;

  final int placesCount;

  final int progressPercent;

  final GeneratedPlanEntity plan;

  final CollectedPlannerDataEntity? collected;

  final DateTime createdAt;

  final DateTime updatedAt;

  @override
  List<Object?> get props => [
    tripId,
    title,
    city,
    destinationGovernorate,
    tripStart,
    tripEnd,
    durationDays,
    people,
    totalBudget,
    totalCost,
    status,
    shareToken,
    isPublic,
    sessionId,
    coverImageUrl,
    placesCount,
    progressPercent,
    plan,
    collected,
    createdAt,
    updatedAt,
  ];
}
